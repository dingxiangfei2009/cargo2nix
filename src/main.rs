use std::{
    borrow::{Borrow, Cow},
    collections::{BTreeMap, BTreeSet, HashMap},
    fmt::{self, Write},
    path::Path,
    rc::Rc,
};

use cargo::{
    core::{
        dependency::Kind as DependencyKind,
        resolver::{Method, Resolve},
        InternedString, Package, PackageId, PackageIdSpec, SourceId, Workspace,
    },
    ops::{resolve_ws_with_method, Packages},
    util::important_paths::find_root_manifest_for_wd,
};

use crate::{
    expr::BoolExpr,
    fmt_ext::{DisplayFn, Indented},
};
use cargo::core::dependency::Platform;

pub mod expr;
pub mod fmt_ext;
pub mod manifest;
pub mod platform;

type Feature<'a> = &'a str;
type PackageName<'a> = &'a str;
type RootFeature<'a> = (PackageName<'a>, Feature<'a>);

fn main() {
    let config = {
        let mut c = cargo::Config::default().unwrap();
        c.configure(0, None, &None, false, true, false, &None, &[])
            .unwrap();
        c
    };
    let root_manifest_path = find_root_manifest_for_wd(config.cwd()).unwrap();
    let ws = Workspace::new(&root_manifest_path, &config).unwrap();

    let (package_set, resolve) = resolve_ws_with_method(
        &ws,
        Method::Required {
            dev_deps: true,
            features: Rc::new(Default::default()),
            all_features: true,
            uses_default_features: true,
        },
        &Packages::All.to_package_id_specs(&ws).unwrap(),
    )
    .unwrap();

    let pkgs_by_id = package_set
        .get_many(package_set.package_ids())
        .unwrap()
        .iter()
        .map(|pkg| (pkg.package_id(), *pkg))
        .collect::<HashMap<_, _>>();

    let mut rpkgs_by_id = package_set
        .get_many(package_set.package_ids())
        .unwrap()
        .iter()
        .map(|pkg| {
            (
                pkg.package_id(),
                ResolvedPackage::new(pkg, &pkgs_by_id, &resolve),
            )
        })
        .collect::<BTreeMap<_, _>>();

    let root_pkgs = ws.members().collect::<Vec<_>>();
    for pkg in root_pkgs.iter() {
        let pkg_ws = Workspace::new(pkg.manifest_path(), &config).unwrap();
        mark_required(pkg, &pkg_ws, &mut rpkgs_by_id);
        for feature in all_features(&pkg) {
            activate(pkg, feature, &pkg_ws, &mut rpkgs_by_id);
        }
    }

    let profiles = manifest::extract_profiles(&std::fs::read(&root_manifest_path).unwrap());
    let scope = Scope::default();
    let display = DisplayFn(|f: &mut fmt::Formatter| {
        let mut f = Indented::new(f);
        writeln!(f, "{{")?;
        {
            let mut f = f.indent(2);
            writeln!(f, "{} ? true,", scope.release)?;
            writeln!(
                f,
                "rootFeatures ? {},",
                display_default_features_nix(&root_pkgs)
            )?;
            writeln!(f, "{},", scope.crates)?;
            writeln!(f, "{},", scope.build_crates)?;
            writeln!(f, "{},", scope.host_platform)?;
            writeln!(f, "mkRustCrate,")?;
            writeln!(f, "rustLib,")?;
            writeln!(f, "lib,")?;
        }
        writeln!(f, "}}:")?;
        writeln!(f, "let")?;
        {
            let mut f = f.indent(2);
            writeln!(
                f,
                "inherit (rustLib) {} {} {} {} decideProfile genDrvsByProfile;",
                scope.fetch_crate_crates_io,
                scope.fetch_crate_local,
                scope.fetch_crate_git,
                scope.expand_features,
            )?;
            writeln!(f, "profilesByName = {};", display_profiles_nix(&profiles))?;
            writeln!(
                f,
                "{} = {} rootFeatures;",
                scope.root_features, scope.expand_features
            )?;
            writeln!(f, "{} = f:", scope.mk_rust_crate)?;
            {
                let mut f = f.indent(2);
                writeln!(f, "let")?;
                writeln!(
                    f.indent(2),
                    "drvs = genDrvsByProfile profilesByName (attrs: mkRustCrate (f attrs));"
                )?;
                writeln!(
                    f,
                    "in {{ compileMode ? null, profileName ? decideProfile compileMode release }}:"
                )?;
                writeln!(f.indent(2), "let drv = drvs.${{profileName}}; in if compileMode == null then drv else drv.override {{ inherit compileMode; }};")?;
            }
        }
        writeln!(f, "in")?;
        writeln!(f, "{{")?;
        for rpkg in rpkgs_by_id.values() {
            writeln!(
                f.indent(2),
                "{}",
                rpkg.to_nix(scope, root_pkgs.len(), config.cwd())
            )?;
        }
        writeln!(f, "}}")
    });

    std::println!("{}", display);
}

fn all_features<'a>(p: &'a Package) -> impl 'a + Iterator<Item = Feature<'a>> {
    let features = p.summary().features();
    features
        .keys()
        .map(|k| k.as_str())
        .chain(
            p.dependencies()
                .iter()
                .filter(|d| d.is_optional())
                .map(|d| d.name_in_toml().as_str()),
        )
        .chain(if features.contains_key("default") {
            None
        } else {
            Some("default")
        })
}

fn is_proc_macro(p: &Package) -> bool {
    use cargo::core::{LibKind, TargetKind};

    p.targets()
        .iter()
        .filter_map(|t| match t.kind() {
            TargetKind::Lib(kinds) => Some(kinds.iter()),
            _ => None,
        })
        .flatten()
        .any(|k| *k == LibKind::ProcMacro)
}

/// Traverses the whole dependency graph starting at `pkg` and marks required packages and features.
fn mark_required(
    root_pkg: &Package,
    ws: &Workspace,
    rpkgs_by_id: &mut BTreeMap<PackageId, ResolvedPackage>,
) {
    let (_, resolve) = resolve_ws_with_method(
        ws,
        Method::Required {
            dev_deps: true,
            features: Rc::new(Default::default()),
            all_features: false,
            uses_default_features: false,
        },
        &[PackageIdSpec::from_package_id(root_pkg.package_id())],
    )
    .unwrap();

    let root_pkg_name = root_pkg.name().as_str();
    // Dependencies that are activated, even when no features are activated, must be required.
    for id in resolve.iter() {
        let rpkg = rpkgs_by_id.get_mut(&id).unwrap();
        for feature in resolve.features(id).iter() {
            rpkg.features
                .get_mut(feature.as_str())
                .unwrap()
                .required_by(root_pkg_name);
        }

        for (dep_id, _) in resolve.deps(id) {
            for dep in rpkg.iter_deps_with_id_mut(dep_id) {
                dep.optionality.required_by(root_pkg_name);
            }
        }
    }
}

fn activate<'a>(
    pkg: &'a Package,
    feature: Feature<'a>,
    ws: &Workspace,
    rpkgs_by_id: &mut BTreeMap<PackageId, ResolvedPackage<'a>>,
) {
    let (_, resolve) = resolve_ws_with_method(
        ws,
        Method::Required {
            dev_deps: true,
            features: Rc::new({
                let mut s = BTreeSet::new();
                if feature != "default" {
                    s.insert(InternedString::new(feature));
                }
                s
            }),
            all_features: false,
            uses_default_features: feature == "default",
        },
        &[PackageIdSpec::from_package_id(pkg.package_id())],
    )
    .unwrap();

    let root_feature = (pkg.name().as_str(), feature);
    for id in resolve.iter() {
        let rpkg = rpkgs_by_id.get_mut(&id).unwrap();
        for feature in resolve.features(id).iter() {
            rpkg.features
                .get_mut(feature.as_str())
                .unwrap()
                .activated_by(root_feature);
        }

        for (dep_id, _) in resolve.deps(id) {
            for dep in rpkg.iter_deps_with_id_mut(dep_id) {
                dep.optionality.activated_by(root_feature)
            }
        }
    }
}

#[derive(Copy, Clone)]
struct Scope<'a> {
    crates: &'a str,
    build_crates: &'a str,
    root_features: &'a str,
    expand_features: &'a str,
    release: &'a str,
    mk_rust_crate: &'a str,
    fetch_crate_crates_io: &'a str,
    fetch_crate_git: &'a str,
    fetch_crate_local: &'a str,
    optional: &'a str,
    host_platform: &'a str,
}

impl Default for Scope<'static> {
    fn default() -> Self {
        Self {
            crates: "rustPackages",
            build_crates: "buildRustPackages",
            root_features: "rootFeatures'",
            expand_features: "expandFeatures",
            release: "release",
            mk_rust_crate: "overridableMkRustCrate",
            fetch_crate_crates_io: "fetchCratesIo",
            fetch_crate_git: "fetchCrateGit",
            fetch_crate_local: "fetchCrateLocal",
            optional: "lib.optional",
            host_platform: "hostPlatform",
        }
    }
}

#[derive(Debug)]
struct ResolvedPackage<'a> {
    pkg: &'a Package,
    deps: BTreeMap<(PackageId, DependencyKind), ResolvedDependency<'a>>,
    features: BTreeMap<Feature<'a>, Optionality<'a>>,
    checksum: Option<Cow<'a, str>>,
}

#[derive(Debug)]
struct ResolvedDependency<'a> {
    extern_name: String,
    pkg: &'a Package,
    optionality: Optionality<'a>,
    platforms: Option<Vec<&'a Platform>>,
}

#[derive(Debug, Default)]
struct Optionality<'a> {
    required_by_pkgs: BTreeSet<PackageName<'a>>,
    activated_by_features: Vec<RootFeature<'a>>,
}

impl<'a> ResolvedPackage<'a> {
    fn new(
        pkg: &'a Package,
        pkgs_by_id: &HashMap<PackageId, &'a Package>,
        resolve: &'a Resolve,
    ) -> Self {
        let mut deps = BTreeMap::new();
        resolve
            .deps(pkg.package_id())
            .filter_map(|(dep_id, deps)| {
                let dep_pkg = pkgs_by_id[&dep_id];
                let extern_name = resolve
                    .extern_crate_name(
                        pkg.package_id(),
                        dep_id,
                        dep_pkg.targets().iter().find(|t| t.is_lib())?,
                    )
                    .ok()?;

                Some(
                    deps.iter()
                        .map(move |dep| (dep_id, dep, dep_pkg, extern_name.clone())),
                )
            })
            .flatten()
            .for_each(|(dep_id, dep, dep_pkg, extern_name)| {
                let rdep = deps
                    .entry((dep_id, dep.kind()))
                    .or_insert(ResolvedDependency {
                        extern_name,
                        pkg: dep_pkg,
                        optionality: Optionality::default(),
                        platforms: Some(Vec::new()),
                    });

                match (dep.platform(), rdep.platforms.as_mut()) {
                    (Some(platform), Some(platforms)) => platforms.push(platform),
                    (None, _) => rdep.platforms = None,
                    _ => {}
                }
            });

        Self {
            pkg,
            deps,
            features: resolve
                .features(pkg.package_id())
                .iter()
                .map(|feature| (feature.as_str(), Optionality::default()))
                .collect(),
            checksum: resolve
                .checksums()
                .get(&pkg.package_id())
                .and_then(|s| s.as_ref().map(|s| Cow::Borrowed(s.as_str())))
                .or_else(|| {
                    let source_id = pkg.package_id().source_id();
                    if source_id.is_git() {
                        Some(Cow::Owned(
                            prefetch_git(
                                source_id.url().as_str(),
                                source_id.precise().unwrap_or_else(|| {
                                    panic!("no precise git reference for {}", pkg.package_id())
                                }),
                            )
                            .unwrap_or_else(|e| {
                                panic!(
                                    "failed to compute SHA256 for {} using nix-prefetch-git: {}",
                                    pkg.package_id(),
                                    e
                                )
                            }),
                        ))
                    } else {
                        None
                    }
                }),
        }
    }

    fn iter_deps_with_id_mut(
        &mut self,
        id: PackageId,
    ) -> impl Iterator<Item = &mut ResolvedDependency<'a>> {
        self.deps
            .range_mut((id, DependencyKind::Normal)..=(id, DependencyKind::Build))
            .map(|(_, dep)| dep)
    }

    fn to_nix<'b, 'c>(
        &'b self,
        outer: Scope<'c>,
        n_root_pkgs: usize,
        cwd: &'b Path,
    ) -> impl 'b + fmt::Display
    where
        'c: 'b,
    {
        DisplayFn(move |f: &mut fmt::Formatter| self.write_nix(f, outer, n_root_pkgs, cwd))
    }

    fn write_nix<W>(&self, f: W, outer: Scope, n_root_pkgs: usize, cwd: &Path) -> fmt::Result
    where
        W: Write,
    {
        use self::BoolExpr::*;

        let mut f = Indented::new(f);
        writeln!(
            f,
            "{} = {} ({{ profileName, profile }}: {{",
            display_pkg_id_nix(self.pkg.package_id()),
            outer.mk_rust_crate
        )?;
        {
            let mut f = f.indent(2);
            writeln!(f, "inherit {} profile;", outer.release)?;
            writeln!(f, "name = {:?};", self.pkg.name())?;
            writeln!(f, "version = {:?};", self.pkg.version().to_string())?;
            writeln!(
                f,
                "registry = {:?};",
                display_source_id(self.pkg.package_id().source_id()).to_string()
            )?;
            writeln!(
                f,
                "src = {};",
                display_source_nix(
                    self.pkg.package_id(),
                    outer,
                    self.checksum.as_ref().map(|c| c.borrow()),
                    cwd
                )
            )?;
            writeln!(f, "features = builtins.concatLists [")?;
            for (feature, optionality) in self.features.iter() {
                let mut f = f.indent(2);
                match optionality
                    .to_expr(outer.root_features, n_root_pkgs)
                    .simplify()
                {
                    True => writeln!(f, "[ {:?} ]", feature)?,
                    expr => writeln!(f, "({} ({}) {:?})", outer.optional, expr.to_nix(), feature)?,
                }
            }
            writeln!(f, "];")?;

            for (attr, kind) in &[
                ("dependencies", DependencyKind::Normal),
                ("devDependencies", DependencyKind::Development),
                ("buildDependencies", DependencyKind::Build),
            ] {
                writeln!(f, "{} = {{", attr)?;

                for ((dep_id, _), rdep) in self
                    .deps
                    .iter()
                    .filter(|((_, dep_kind), _)| dep_kind == kind)
                {
                    let mut f = f.indent(2);
                    match rdep
                        .optionality
                        .to_expr(outer.root_features, n_root_pkgs)
                        .and(match rdep.platforms {
                            Some(ref platforms) => BoolExpr::ors(
                                platforms
                                    .iter()
                                    .map(|p| platform::to_expr(p, outer.host_platform)),
                            ),
                            None => BoolExpr::True,
                        })
                        .simplify()
                    {
                        True => write!(f, "{}", rdep.extern_name,)?,
                        expr => write!(
                            f,
                            "${{ if {} then {:?} else null }}",
                            expr.to_nix(),
                            rdep.extern_name,
                        )?,
                    }

                    let is_build_dep = *kind == DependencyKind::Build || is_proc_macro(rdep.pkg);
                    let crate_set = if is_build_dep {
                        outer.build_crates
                    } else {
                        outer.crates
                    };
                    write!(
                        f,
                        " = {}.{} ",
                        crate_set,
                        display_pkg_id_nix(dep_id.clone()),
                    )?;
                    if is_build_dep {
                        write!(f, r#"{{ profileName = "__noProfile"; }}"#)?;
                    } else {
                        write!(f, r#"{{ inherit profileName; }}"#)?;
                    }
                    writeln!(f, ";")?;
                }
                writeln!(f, "}};")?;
            }
        }
        writeln!(f, "}});")
    }
}

impl<'a> Optionality<'a> {
    fn activated_by(&mut self, (pkg_name, feature): RootFeature<'a>) {
        if !self.required_by_pkgs.contains(pkg_name) {
            self.activated_by_features.push((pkg_name, feature));
        }
    }

    fn required_by(&mut self, pkg_name: PackageName<'a>) {
        self.required_by_pkgs.insert(pkg_name);
    }

    fn to_expr(&self, root_features_var: &str, n_root_pkgs: usize) -> BoolExpr {
        use self::BoolExpr::*;
        if self.required_by_pkgs.len() == n_root_pkgs {
            // Required by all root packages, no conditioning needed.
            True
        } else {
            BoolExpr::ors(
                self.activated_by_features
                    .iter()
                    .map(|root_feature| {
                        Single(format!(
                            "{} ? {:?}",
                            root_features_var,
                            display_root_feature(*root_feature)
                        ))
                    })
                    .chain(
                        self.required_by_pkgs.iter().map(|pkg_name| {
                            Single(format!("{} ? {:?}", root_features_var, pkg_name))
                        }),
                    ),
            )
        }
    }
}

fn display_source_nix<'a, 'b, 'c>(
    p: PackageId,
    scope: Scope<'b>,
    checksum: Option<&'c str>,
    cwd: &'a Path,
) -> impl 'a + fmt::Display
where
    'b: 'a,
    'c: 'a,
{
    DisplayFn(move |f: &mut fmt::Formatter| write_source_nix(f, p, scope, checksum, cwd))
}

fn write_source_nix<W: Write>(
    f: W,
    p: PackageId,
    scope: Scope,
    checksum: Option<&str>,
    cwd: &Path,
) -> fmt::Result {
    let source_id = p.source_id();

    let mut f = Indented::new(f);
    if source_id.is_default_registry() {
        writeln!(f, "{} {{", scope.fetch_crate_crates_io)?;
        {
            let mut f = f.indent(2);
            writeln!(f, "name = {:?};", p.name())?;
            writeln!(f, "version = {:?};", p.version().to_string())?;
            writeln!(
                f,
                "sha256 = {:?};",
                checksum
                    .unwrap_or_else(|| panic!("checksum is required for crates.io package {}", p))
            )?
        }
        write!(f, "}}")
    } else if source_id.is_git() {
        writeln!(f, "{} {{", scope.fetch_crate_git)?;
        {
            let mut f = f.indent(2);
            writeln!(f, "url = {:?};", source_id.url().to_string())?;
            writeln!(f, "name = {:?};", p.name())?;
            writeln!(f, "version = {:?};", p.version().to_string())?;
            writeln!(
                f,
                "rev = {:?};",
                source_id
                    .precise()
                    .unwrap_or_else(|| panic!("precise ref not found for git package {}", p))
            )?;
            writeln!(
                f,
                "sha256 = {:?};",
                checksum.unwrap_or_else(|| panic!("checksum is required for git package {}", p))
            )?;
        }
        write!(f, "}}")
    } else if source_id.is_path() {
        write!(
            f,
            "{} ./{}",
            scope.fetch_crate_local,
            pathdiff::diff_paths(Path::new(source_id.url().path()), cwd)
                .unwrap_or_else(|| panic!("path is not absolute for local package {}", p))
                .join(".")
                .display()
        )
    } else {
        panic!("unsupported source {}", p)
    }
}

fn display_root_feature((pkg_name, feature): RootFeature) -> String {
    format!("{}/{}", pkg_name, feature)
}

fn display_source_id(id: SourceId) -> impl fmt::Display {
    DisplayFn(move |f: &mut fmt::Formatter| {
        if id.is_path() {
            write!(f, "unknown")
        } else if id.is_git() {
            write!(f, "git+{}", id.url())
        } else {
            write!(f, "{}", id.into_url())
        }
    })
}

fn display_pkg_id_nix(id: PackageId) -> impl fmt::Display {
    DisplayFn(move |f: &mut fmt::Formatter| {
        write!(
            f,
            "{:?}.{}.{:?}",
            display_source_id(id.source_id()).to_string(),
            id.name(),
            id.version().to_string(),
        )
    })
}

fn display_default_features_nix<'a>(pkgs: &'a [&Package]) -> impl 'a + fmt::Display {
    DisplayFn(move |f: &mut fmt::Formatter| {
        let mut f = Indented::new(f);
        writeln!(f, "[")?;
        for pkg in pkgs.iter() {
            writeln!(f.indent(2), "{:?} ", format!("{}/default", pkg.name()))?;
        }
        write!(f, "]")
    })
}

fn prefetch_git(url: &str, rev: &str) -> Result<String, Box<dyn std::error::Error>> {
    let std::process::Output {
        stdout,
        stderr,
        status,
    } = std::process::Command::new("nix-prefetch-git")
        .arg("--quiet")
        .args(&["--url", url])
        .args(&["--rev", rev])
        .output()?;

    if status.success() {
        Ok(serde_json::from_slice::<serde_json::Value>(&stdout)?
            .get("sha256")
            .and_then(|v| v.as_str())
            .map(|s| s.to_string())
            .ok_or("unexpected JSON output")?)
    } else {
        Err(format!(
            "process failed with stderr {:?}",
            String::from_utf8(stderr)
        ))?
    }
}

fn display_profiles_nix(profiles: &manifest::TomlProfile) -> impl '_ + fmt::Display {
    DisplayFn(move |f: &mut fmt::Formatter| {
        let mut f = Indented::new(f);
        writeln!(f, "{{")?;
        for (name, profile) in profiles.iter() {
            let mut f = f.indent(2);
            writeln!(
                f,
                "{} = builtins.fromTOML {:?};",
                name,
                toml::to_string(profile).unwrap()
            )?;
        }
        write!(f, "}}")
    })
}
