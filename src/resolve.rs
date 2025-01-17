use cargo::core::resolver::Method;
use cargo::core::{PackageIdSpec, Workspace};
use cargo::{
    ops::resolve_ws_with_method, util::important_paths::find_root_manifest_for_wd, Config,
};

pub fn resolve(method: Method, specs: &[PackageIdSpec]) {
    let root_manifest_path = find_root_manifest_for_wd(&std::env::current_dir().unwrap()).unwrap();
    let ws = Workspace::new(
        &root_manifest_path,
        &Config {
            locked: true,
            ..Config::default().unwrap()
        },
    );

    resolve_ws_with_method(ws, method, specs)
}
