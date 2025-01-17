{
  release ? true,
  rootFeatures ? [
    "cargo2nix/default" 
  ],
  rustPackages,
  buildRustPackages,
  hostPlatform,
  mkRustCrate,
  rustLib,
  lib,
}:
let
  inherit (rustLib) fetchCratesIo fetchCrateLocal fetchCrateGit expandFeatures decideProfile genDrvsByProfile;
  profilesByName = {
  };
  rootFeatures' = expandFeatures rootFeatures;
  overridableMkRustCrate = f:
    let
      drvs = genDrvsByProfile profilesByName (attrs: mkRustCrate (f attrs));
    in { compileMode ? null, profileName ? decideProfile compileMode release }:
      let drv = drvs.${profileName}; in if compileMode == null then drv else drv.override { inherit compileMode; };
in
{
  "registry+https://github.com/rust-lang/crates.io-index".adler32."1.0.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "adler32";
    version = "1.0.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "adler32";
      version = "1.0.4";
      sha256 = "5d2e7343e7fc9de883d1b0341e0b13970f764c14101234857d2ddafa1cb1cac2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "aho-corasick";
    version = "0.7.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "aho-corasick";
      version = "0.7.6";
      sha256 = "58fb5e95d83b38284460a5fda7d6470aa0b8844d283a0b614b8535e880800d2d";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ansi_term."0.11.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "ansi_term";
    version = "0.11.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ansi_term";
      version = "0.11.0";
      sha256 = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.parsed.kernel.name == "windows" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "atty";
    version = "0.2.13";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "atty";
      version = "0.2.13";
      sha256 = "1803c647a3ec87095e7ae7acfca019e98de5ec9a7d01343f611cf3152ed71a90";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".autocfg."0.1.7" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "autocfg";
    version = "0.1.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "autocfg";
      version = "0.1.7";
      sha256 = "1d49d90015b3c36167a20fe2810c5cd875ad504b39cff3d4eae7977e6b7c1cb2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".backtrace."0.3.40" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "backtrace";
    version = "0.3.40";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "backtrace";
      version = "0.3.40";
      sha256 = "924c76597f0d9ca25d762c25a4d369d51267536465dc5064bdf0eb073ed477ea";
    };
    features = builtins.concatLists [
      [ "backtrace-sys" ]
      [ "dbghelp" ]
      [ "default" ]
      [ "dladdr" ]
      [ "libbacktrace" ]
      [ "libunwind" ]
      [ "std" ]
    ];
    dependencies = {
      backtrace_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".backtrace-sys."0.1.32" { inherit profileName; };
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      rustc_demangle = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc-demangle."0.1.16" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".backtrace-sys."0.1.32" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "backtrace-sys";
    version = "0.1.32";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "backtrace-sys";
      version = "0.1.32";
      sha256 = "5d6575f128516de27e3ce99689419835fce9643a9b215a14d2b5b685be018491";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "bitflags";
    version = "1.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bitflags";
      version = "1.2.1";
      sha256 = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bstr."0.2.8" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "bstr";
    version = "0.2.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bstr";
      version = "0.2.8";
      sha256 = "8d6c2c5b58ab920a4f5aeaaca34b4488074e8cc7596af94e6f8c6ff247c60245";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "byteorder";
    version = "1.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "byteorder";
      version = "1.3.2";
      sha256 = "a7c3dd8985a7111efc5c80b44e23ecdd8c007de8ade3b96595387e812b957cf5";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bytes."0.4.12" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "bytes";
    version = "0.4.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bytes";
      version = "0.4.12";
      sha256 = "206fdffcfa2df7cbe15601ef46c813fce0965eb3286db6b56c583b814b51c81c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      byteorder = rustPackages."registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" { inherit profileName; };
      iovec = rustPackages."registry+https://github.com/rust-lang/crates.io-index".iovec."0.1.4" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bytesize."1.0.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "bytesize";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bytesize";
      version = "1.0.0";
      sha256 = "716960a18f978640f25101b5cbf1c6f6b0d3192fab36a2d98ca96f0ecbe41010";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".c2-chacha."0.2.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "c2-chacha";
    version = "0.2.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "c2-chacha";
      version = "0.2.3";
      sha256 = "214238caa1bf3a496ec3392968969cab8549f96ff30652c9e56885329315f6bb";
    };
    features = builtins.concatLists [
      [ "simd" ]
      [ "std" ]
    ];
    dependencies = {
      ppv_lite86 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ppv-lite86."0.2.6" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".cargo."0.39.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "cargo";
    version = "0.39.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cargo";
      version = "0.39.0";
      sha256 = "92848afb3f52015ba227aa1480c2861f800f92edd41d6536eaaa44ddc8b97837";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { inherit profileName; };
      byteorder = rustPackages."registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" { inherit profileName; };
      bytesize = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bytesize."1.0.0" { inherit profileName; };
      clap = rustPackages."registry+https://github.com/rust-lang/crates.io-index".clap."2.33.0" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "darwin" then "core_foundation" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".core-foundation."0.6.4" { inherit profileName; };
      crates_io = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crates-io."0.27.0" { inherit profileName; };
      crossbeam_utils = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" { inherit profileName; };
      crypto_hash = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crypto-hash."0.3.4" { inherit profileName; };
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { inherit profileName; };
      curl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" { inherit profileName; };
      env_logger = rustPackages."registry+https://github.com/rust-lang/crates.io-index".env_logger."0.6.2" { inherit profileName; };
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { inherit profileName; };
      filetime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" { inherit profileName; };
      flate2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".flate2."1.0.12" { inherit profileName; };
      fs2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fs2."0.4.3" { inherit profileName; };
      ${ if hostPlatform.isWindows then "fwdansi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fwdansi."1.0.1" { inherit profileName; };
      git2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" { inherit profileName; };
      git2_curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2-curl."0.10.1" { inherit profileName; };
      glob = rustPackages."registry+https://github.com/rust-lang/crates.io-index".glob."0.3.0" { inherit profileName; };
      hex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" { inherit profileName; };
      home = rustPackages."registry+https://github.com/rust-lang/crates.io-index".home."0.3.4" { inherit profileName; };
      ignore = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ignore."0.4.10" { inherit profileName; };
      im_rc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".im-rc."13.0.0" { inherit profileName; };
      jobserver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".jobserver."0.1.17" { inherit profileName; };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
      lazycell = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazycell."1.2.1" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libgit2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
      ${ if hostPlatform.isWindows then "miow" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".miow."0.3.3" { inherit profileName; };
      num_cpus = rustPackages."registry+https://github.com/rust-lang/crates.io-index".num_cpus."1.10.1" { inherit profileName; };
      opener = rustPackages."registry+https://github.com/rust-lang/crates.io-index".opener."0.4.1" { inherit profileName; };
      rustc_workspace_hack = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc-workspace-hack."1.0.0" { inherit profileName; };
      rustfix = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustfix."0.4.6" { inherit profileName; };
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { inherit profileName; };
      semver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
      serde_ignored = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_ignored."0.0.4" { inherit profileName; };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { inherit profileName; };
      shell_escape = rustPackages."registry+https://github.com/rust-lang/crates.io-index".shell-escape."0.1.4" { inherit profileName; };
      strip_ansi_escapes = rustPackages."registry+https://github.com/rust-lang/crates.io-index".strip-ansi-escapes."0.1.0" { inherit profileName; };
      tar = rustPackages."registry+https://github.com/rust-lang/crates.io-index".tar."0.4.26" { inherit profileName; };
      tempfile = rustPackages."registry+https://github.com/rust-lang/crates.io-index".tempfile."3.1.0" { inherit profileName; };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { inherit profileName; };
      toml = rustPackages."registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" { inherit profileName; };
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { inherit profileName; };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { inherit profileName; };
      url_serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url_serde."0.2.0" { inherit profileName; };
      walkdir = rustPackages."registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "unknown".cargo2nix."0.5.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "cargo2nix";
    version = "0.5.0";
    registry = "unknown";
    src = fetchCrateLocal ./.;
    features = builtins.concatLists [
    ];
    dependencies = {
      cargo = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cargo."0.39.0" { inherit profileName; };
      once_cell = rustPackages."registry+https://github.com/rust-lang/crates.io-index".once_cell."1.2.0" { inherit profileName; };
      pathdiff = rustPackages."registry+https://github.com/rust-lang/crates.io-index".pathdiff."0.1.0" { inherit profileName; };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { inherit profileName; };
      toml = rustPackages."registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "cc";
    version = "1.0.46";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cc";
      version = "1.0.46";
      sha256 = "0213d356d3c4ea2c18c40b037c3be23cd639825c18f25ee670ac7813beeef99c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "cfg-if";
    version = "0.1.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cfg-if";
      version = "0.1.10";
      sha256 = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".clap."2.33.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "clap";
    version = "2.33.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "clap";
      version = "2.33.0";
      sha256 = "5067f5bb2d80ef5d68b4c87db81601f0b75bca627bc2ef76b141d7b846a3c6d9";
    };
    features = builtins.concatLists [
      [ "ansi_term" ]
      [ "atty" ]
      [ "color" ]
      [ "default" ]
      [ "strsim" ]
      [ "suggestions" ]
      [ "vec_map" ]
    ];
    dependencies = {
      ${ if !hostPlatform.isWindows then "ansi_term" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ansi_term."0.11.0" { inherit profileName; };
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { inherit profileName; };
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { inherit profileName; };
      strsim = rustPackages."registry+https://github.com/rust-lang/crates.io-index".strsim."0.8.0" { inherit profileName; };
      textwrap = rustPackages."registry+https://github.com/rust-lang/crates.io-index".textwrap."0.11.0" { inherit profileName; };
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { inherit profileName; };
      vec_map = rustPackages."registry+https://github.com/rust-lang/crates.io-index".vec_map."0.8.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".commoncrypto."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "commoncrypto";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "commoncrypto";
      version = "0.2.0";
      sha256 = "d056a8586ba25a1e4d61cb090900e495952c7886786fc55f909ab2f819b69007";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      commoncrypto_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".commoncrypto-sys."0.2.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".commoncrypto-sys."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "commoncrypto-sys";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "commoncrypto-sys";
      version = "0.2.0";
      sha256 = "1fed34f46747aa73dfaa578069fd8279d2818ade2b55f38f22a9401c7f4083e2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".core-foundation."0.6.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "core-foundation";
    version = "0.6.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "core-foundation";
      version = "0.6.4";
      sha256 = "25b9e03f145fd4f2bf705e07b900cd41fc636598fe5dc452fd0db1441c3f496d";
    };
    features = builtins.concatLists [
      [ "mac_os_10_7_support" ]
    ];
    dependencies = {
      core_foundation_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".core-foundation-sys."0.6.2" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".core-foundation-sys."0.6.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "core-foundation-sys";
    version = "0.6.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "core-foundation-sys";
      version = "0.6.2";
      sha256 = "e7ca8a5221364ef15ce201e8ed2f609fc312682a8f4e0e3d4aa5879764e0fa3b";
    };
    features = builtins.concatLists [
      [ "mac_os_10_7_support" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".crates-io."0.27.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "crates-io";
    version = "0.27.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crates-io";
      version = "0.27.0";
      sha256 = "3605c99a8cbb106e6cc954a4cf9e46124f38b541d1243245e480f85cb909d64b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { inherit profileName; };
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { inherit profileName; };
      http = rustPackages."registry+https://github.com/rust-lang/crates.io-index".http."0.1.19" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
      serde_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" { profileName = "__noProfile"; };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { inherit profileName; };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".crc32fast."1.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "crc32fast";
    version = "1.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crc32fast";
      version = "1.2.0";
      sha256 = "ba125de2af0df55319f41944744ad91c71113bf74a4646efff39afe1f6842db1";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".crossbeam-channel."0.3.9" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "crossbeam-channel";
    version = "0.3.9";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crossbeam-channel";
      version = "0.3.9";
      sha256 = "c8ec7fcd21571dc78f96cc96243cab8d8f035247c3efd16c687be154c3fa9efa";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      crossbeam_utils = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "crossbeam-utils";
    version = "0.6.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crossbeam-utils";
      version = "0.6.6";
      sha256 = "04973fa96e96579258a5091af6003abde64af786b860f18622b82e026cca60e6";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "lazy_static" ]
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".crypto-hash."0.3.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "crypto-hash";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crypto-hash";
      version = "0.3.4";
      sha256 = "8a77162240fd97248d19a564a565eb563a3f592b386e4136fb300909e67dddca";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.parsed.kernel.name == "darwin" || hostPlatform.parsed.kernel.name == "ios" then "commoncrypto" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".commoncrypto."0.2.0" { inherit profileName; };
      hex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" { inherit profileName; };
      ${ if !(hostPlatform.parsed.kernel.name == "windows" || hostPlatform.parsed.kernel.name == "darwin" || hostPlatform.parsed.kernel.name == "ios") then "openssl" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.25" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "windows" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "curl";
    version = "0.4.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "curl";
      version = "0.4.25";
      sha256 = "06aa71e9208a54def20792d877bc663d6aae0732b9852e612c4a933177c31283";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "http2" ]
      [ "openssl-probe" ]
      [ "openssl-sys" ]
      [ "ssl" ]
    ];
    dependencies = {
      curl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_probe" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" { inherit profileName; };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "schannel" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".schannel."0.1.16" { inherit profileName; };
      socket2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" { inherit profileName; };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "curl-sys";
    version = "0.4.23";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "curl-sys";
      version = "0.4.23";
      sha256 = "f71cd2dbddb49c744c1c9e0b96106f50a634e8759ec51bcd5399a578700a3ab3";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "http2" ]
      [ "libnghttp2-sys" ]
      [ "openssl-sys" ]
      [ "ssl" ]
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libnghttp2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libnghttp2-sys."0.1.2" { inherit profileName; };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { inherit profileName; };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") || hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
      ${ if hostPlatform.isWindows || hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { profileName = "__noProfile"; };
      ${ if hostPlatform.parsed.abi.name == "msvc" || hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".env_logger."0.6.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "env_logger";
    version = "0.6.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "env_logger";
      version = "0.6.2";
      sha256 = "aafcde04e90a5226a6443b7aabdb016ba2f8307c847d524724bd9b346dd1a2d3";
    };
    features = builtins.concatLists [
      [ "atty" ]
      [ "default" ]
      [ "humantime" ]
      [ "regex" ]
      [ "termcolor" ]
    ];
    dependencies = {
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { inherit profileName; };
      humantime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".humantime."1.3.0" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { inherit profileName; };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "failure";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "failure";
      version = "0.1.6";
      sha256 = "f8273f13c977665c5db7eb2b99ae520952fe5ac831ae4cd09d80c4c7042b5ed9";
    };
    features = builtins.concatLists [
      [ "backtrace" ]
      [ "default" ]
      [ "derive" ]
      [ "failure_derive" ]
      [ "std" ]
    ];
    dependencies = {
      backtrace = rustPackages."registry+https://github.com/rust-lang/crates.io-index".backtrace."0.3.40" { inherit profileName; };
      failure_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".failure_derive."0.1.6" { profileName = "__noProfile"; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".failure_derive."0.1.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "failure_derive";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "failure_derive";
      version = "0.1.6";
      sha256 = "0bc225b78e0391e4b8683440bf2e63c2deeeb2ce5189eab46e2b68c6d3725d08";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { inherit profileName; };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { inherit profileName; };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { inherit profileName; };
      synstructure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".synstructure."0.12.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "filetime";
    version = "0.2.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "filetime";
      version = "0.2.7";
      sha256 = "6bd7380b54ced79dda72ecc35cc4fbbd1da6bba54afaa37e96fd1c2a308cd469";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".flate2."1.0.12" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "flate2";
    version = "1.0.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "flate2";
      version = "1.0.12";
      sha256 = "ad3c5233c9a940c8719031b423d7e6c16af66e031cb0420b0896f5245bf181d3";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "libz-sys" ]
      [ "miniz_oxide" ]
      [ "rust_backend" ]
      [ "zlib" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      crc32fast = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crc32fast."1.2.0" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { inherit profileName; };
      miniz_oxide = rustPackages."registry+https://github.com/rust-lang/crates.io-index".miniz_oxide."0.3.3" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "fnv";
    version = "1.0.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fnv";
      version = "1.0.6";
      sha256 = "2fad85553e09a6f881f739c29f0b00b0f01357c743266d478b68951ce23285f3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".foreign-types."0.3.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "foreign-types";
    version = "0.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "foreign-types";
      version = "0.3.2";
      sha256 = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      foreign_types_shared = rustPackages."registry+https://github.com/rust-lang/crates.io-index".foreign-types-shared."0.1.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".foreign-types-shared."0.1.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "foreign-types-shared";
    version = "0.1.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "foreign-types-shared";
      version = "0.1.1";
      sha256 = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".fs2."0.4.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "fs2";
    version = "0.4.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fs2";
      version = "0.4.3";
      sha256 = "9564fc758e15025b46aa6643b1b77d047d1a56a1aea6e01002ac0c7026876213";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".fwdansi."1.0.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "fwdansi";
    version = "1.0.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fwdansi";
      version = "1.0.1";
      sha256 = "34dd4c507af68d37ffef962063dfa1944ce0dd4d5b82043dbab1dabe088610c3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "getrandom";
    version = "0.1.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "getrandom";
      version = "0.1.12";
      sha256 = "473a1265acc8ff1e808cd0a1af8cee3c2ee5200916058a2ca113c29f2d903571";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" || hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "wasi" || hostPlatform.parsed.kernel.name == "wasi" then "wasi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".wasi."0.7.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "git2";
    version = "0.9.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "git2";
      version = "0.9.2";
      sha256 = "8cb400360e8a4d61b10e648285bbfa919bbf9519d0d5d5720354456f44349226";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "https" ]
      [ "openssl-probe" ]
      [ "openssl-sys" ]
      [ "ssh" ]
      [ "ssh_key_from_memory" ]
    ];
    dependencies = {
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libgit2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_probe" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" { inherit profileName; };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".git2-curl."0.10.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "git2-curl";
    version = "0.10.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "git2-curl";
      version = "0.10.1";
      sha256 = "2293de73491c3dc4174c5949ef53d2cc037b27613f88d72032e3f5237247a7dd";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { inherit profileName; };
      git2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".glob."0.3.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "glob";
    version = "0.3.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "glob";
      version = "0.3.0";
      sha256 = "9b919933a397b79c37e33b77bb2aa3dc8eb6e165ad809e58ff75bc7db2e34574";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".globset."0.4.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "globset";
    version = "0.4.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "globset";
      version = "0.4.4";
      sha256 = "925aa2cac82d8834e2b2a4415b6f6879757fb5c0928fc445ae76461a12eed8f2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      aho_corasick = rustPackages."registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" { inherit profileName; };
      bstr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bstr."0.2.8" { inherit profileName; };
      fnv = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "hex";
    version = "0.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "hex";
      version = "0.3.2";
      sha256 = "805026a5d0141ffc30abb3be3173848ad46a1b1664fe632428479619a3644d77";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".home."0.3.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "home";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "home";
      version = "0.3.4";
      sha256 = "29302b90cfa76231a757a887d1e3153331a63c7f80b6c75f86366334cbe70708";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "scopeguard" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".scopeguard."0.3.3" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".http."0.1.19" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "http";
    version = "0.1.19";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "http";
      version = "0.1.19";
      sha256 = "d7e06e336150b178206af098a055e3621e8336027e2b4d126bda0bc64824baaf";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      bytes = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bytes."0.4.12" { inherit profileName; };
      fnv = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" { inherit profileName; };
      itoa = rustPackages."registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".humantime."1.3.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "humantime";
    version = "1.3.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "humantime";
      version = "1.3.0";
      sha256 = "df004cfca50ef23c36850aaaa59ad52cc70d0e90243c3c7737a4dd32dc7a3c4f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      quick_error = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quick-error."1.2.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".idna."0.1.5" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "idna";
    version = "0.1.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "idna";
      version = "0.1.5";
      sha256 = "38f09e0f0b1fb55fdee1f17470ad800da77af5186a1a76c026b679358b7e844e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { inherit profileName; };
      unicode_bidi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" { inherit profileName; };
      unicode_normalization = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".idna."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "idna";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "idna";
      version = "0.2.0";
      sha256 = "02e2673c30ee86b5b96a9cb52ad15718aa1f966f5ab9ad54a8b95d5ca33120a9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { inherit profileName; };
      unicode_bidi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" { inherit profileName; };
      unicode_normalization = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ignore."0.4.10" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "ignore";
    version = "0.4.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ignore";
      version = "0.4.10";
      sha256 = "0ec16832258409d571aaef8273f3c3cc5b060d784e159d1a0f3b0017308f84a7";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      crossbeam_channel = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-channel."0.3.9" { inherit profileName; };
      globset = rustPackages."registry+https://github.com/rust-lang/crates.io-index".globset."0.4.4" { inherit profileName; };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { inherit profileName; };
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { inherit profileName; };
      thread_local = rustPackages."registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" { inherit profileName; };
      walkdir = rustPackages."registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".im-rc."13.0.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "im-rc";
    version = "13.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "im-rc";
      version = "13.0.0";
      sha256 = "0a0197597d095c0d11107975d3175173f810ee572c2501ff4de64f4f3f119806";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      sized_chunks = rustPackages."registry+https://github.com/rust-lang/crates.io-index".sized-chunks."0.3.1" { inherit profileName; };
      typenum = rustPackages."registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      rustc_version = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc_version."0.2.3" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".iovec."0.1.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "iovec";
    version = "0.1.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "iovec";
      version = "0.1.4";
      sha256 = "b2b3ea6ff95e175473f8ffe6a7eb7c00d054240321b84c57051175fe3c1e075e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "itoa";
    version = "0.4.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "itoa";
      version = "0.4.4";
      sha256 = "501266b7edd0174f8530248f87f99c88fbe60ca4ef3dd486835b8d8d53136f7f";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".jobserver."0.1.17" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "jobserver";
    version = "0.1.17";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "jobserver";
      version = "0.1.17";
      sha256 = "f2b1d42ef453b30b7387e113da1c83ab1605d90c5b4e0eb8e96d016ed3b8c160";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "getrandom" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { inherit profileName; };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "lazy_static";
    version = "1.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "lazy_static";
      version = "1.4.0";
      sha256 = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".lazycell."1.2.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "lazycell";
    version = "1.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "lazycell";
      version = "1.2.1";
      sha256 = "b294d6fa9ee409a054354afc4352b0b9ef7ca222c69b8812cbea9e7d2bf3783f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "libc";
    version = "0.2.65";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libc";
      version = "0.2.65";
      sha256 = "1a31a0627fdf1f6a39ec0dd577e101440b7db22672c0901fe00a9a6fbb5c24e8";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "libgit2-sys";
    version = "0.8.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libgit2-sys";
      version = "0.8.2";
      sha256 = "4c179ed6d19cd3a051e68c177fbbc214e79ac4724fac3a850ec9f3d3eb8a5578";
    };
    features = builtins.concatLists [
      [ "https" ]
      [ "libssh2-sys" ]
      [ "openssl-sys" ]
      [ "ssh" ]
      [ "ssh_key_from_memory" ]
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libssh2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libssh2-sys."0.2.13" { inherit profileName; };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { inherit profileName; };
      ${ if hostPlatform.isUnix then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libnghttp2-sys."0.1.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "libnghttp2-sys";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libnghttp2-sys";
      version = "0.1.2";
      sha256 = "02254d44f4435dd79e695f2c2b83cd06a47919adea30216ceaf0c57ca0a72463";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libssh2-sys."0.2.13" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "libssh2-sys";
    version = "0.2.13";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libssh2-sys";
      version = "0.2.13";
      sha256 = "5fcd5a428a31cbbfe059812d74f4b6cd3b9b7426c2bdaec56993c5365da1c328";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { inherit profileName; };
      ${ if hostPlatform.isUnix then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { profileName = "__noProfile"; };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "libz-sys";
    version = "1.0.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libz-sys";
      version = "1.0.25";
      sha256 = "2eb5e43362e38e2bca2fd5f5134c4d4564a23a5c28e9b95411652021a8675ebe";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { profileName = "__noProfile"; };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "log";
    version = "0.4.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "log";
      version = "0.4.8";
      sha256 = "14b6052be84e6b71ab17edffc2eeabf5c2c3ae1fdb464aae35ac50c67a44e1f7";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "matches";
    version = "0.1.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "matches";
      version = "0.1.8";
      sha256 = "7ffc5c5338469d4d3ea17d269fa8ea3512ad247247c30bd2df69e68309ed0a08";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "memchr";
    version = "2.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "memchr";
      version = "2.2.1";
      sha256 = "88579771288728879b57485cc7d6b07d648c9f0141eb955f8ab7f9d45394468e";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "use_std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".miniz_oxide."0.3.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "miniz_oxide";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "miniz_oxide";
      version = "0.3.3";
      sha256 = "304f66c19be2afa56530fa7c39796192eef38618da8d19df725ad7c6d6b2aaae";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      adler32 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".adler32."1.0.4" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".miow."0.3.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "miow";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "miow";
      version = "0.3.3";
      sha256 = "396aa0f2003d7df8395cb93e09871561ccc3e785f0acb369170e8cc74ddf9226";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      socket2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" { inherit profileName; };
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".num_cpus."1.10.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "num_cpus";
    version = "1.10.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "num_cpus";
      version = "1.10.1";
      sha256 = "bcef43580c035376c0705c42792c294b66974abbfd2789b511784023f71f3273";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".once_cell."1.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "once_cell";
    version = "1.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "once_cell";
      version = "1.2.0";
      sha256 = "891f486f630e5c5a4916c7e16c4b24a53e78c860b646e9f8e005e4f16847bfed";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".opener."0.4.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "opener";
    version = "0.4.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "opener";
      version = "0.4.1";
      sha256 = "13117407ca9d0caf3a0e74f97b490a7e64c0ae3aa90a8b7085544d0c37b6f3ae";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.25" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "openssl";
    version = "0.10.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl";
      version = "0.10.25";
      sha256 = "2f372b2b53ce10fb823a337aaa674e3a7d072b957c6264d0f4ff0bd86e657449";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { inherit profileName; };
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      foreign_types = rustPackages."registry+https://github.com/rust-lang/crates.io-index".foreign-types."0.3.2" { inherit profileName; };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      openssl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "openssl-probe";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl-probe";
      version = "0.1.2";
      sha256 = "77af24da69f9d9341038eba93a073b1fdaaa1b788221b00a69bce9e762cb32de";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "openssl-sys";
    version = "0.9.52";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl-sys";
      version = "0.9.52";
      sha256 = "c977d08e1312e2f7e4b86f9ebaa0ed3b19d1daff75fae88bbb88108afbd801fc";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
      autocfg = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".autocfg."0.1.7" { profileName = "__noProfile"; };
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { profileName = "__noProfile"; };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { profileName = "__noProfile"; };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".pathdiff."0.1.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "pathdiff";
    version = "0.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "pathdiff";
      version = "0.1.0";
      sha256 = "a3bf70094d203e07844da868b634207e71bfab254fe713171fae9a6e751ccf31";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".percent-encoding."1.0.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "percent-encoding";
    version = "1.0.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "percent-encoding";
      version = "1.0.1";
      sha256 = "31010dd2e1ac33d5b46a5b413495239882813e0369f8ed8a5e266f173602f831";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".percent-encoding."2.1.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "percent-encoding";
    version = "2.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "percent-encoding";
      version = "2.1.0";
      sha256 = "d4fd5641d01c8f18a23da7b6fe29298ff4b55afcccdf78973b24cf3175fee32e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "pkg-config";
    version = "0.3.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "pkg-config";
      version = "0.3.16";
      sha256 = "72d5370d90f49f70bd033c3d75e87fc529fbfff9d6f7cccef07d6170079d91ea";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ppv-lite86."0.2.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "ppv-lite86";
    version = "0.2.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ppv-lite86";
      version = "0.2.6";
      sha256 = "74490b50b9fbe561ac330df47c08f3f33073d2d00c150f719147d7c54522fa1b";
    };
    features = builtins.concatLists [
      [ "simd" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "proc-macro2";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "proc-macro2";
      version = "1.0.5";
      sha256 = "90cf5f418035b98e655e9cdb225047638296b862b42411c4e45bb88d700f7fc0";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "proc-macro" ]
    ];
    dependencies = {
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".quick-error."1.2.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "quick-error";
    version = "1.2.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "quick-error";
      version = "1.2.2";
      sha256 = "9274b940887ce9addde99c4eee6b5c44cc494b182b97e73dc8ffdcb3397fd3f0";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "quote";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "quote";
      version = "1.0.2";
      sha256 = "053a8c8bcc71fcce321828dc897a98ab9760bef03a4fc36693c231e5b3216cfe";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "proc-macro" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rand."0.7.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rand";
    version = "0.7.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand";
      version = "0.7.2";
      sha256 = "3ae1b169243eaf61759b8475a998f0a385e42042370f3a7dbaf35246eacc8412";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "getrandom" ]
      [ "getrandom_package" ]
      [ "std" ]
    ];
    dependencies = {
      getrandom_package = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { inherit profileName; };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if !(hostPlatform.parsed.kernel.name == "emscripten") then "rand_chacha" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_chacha."0.2.1" { inherit profileName; };
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "emscripten" then "rand_hc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_hc."0.2.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_chacha."0.2.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rand_chacha";
    version = "0.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_chacha";
      version = "0.2.1";
      sha256 = "03a2a90da8c7523f554344f921aa97283eadf6ac484a6d2a7d0212fa7f8d6853";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      c2_chacha = rustPackages."registry+https://github.com/rust-lang/crates.io-index".c2-chacha."0.2.3" { inherit profileName; };
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rand_core";
    version = "0.5.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_core";
      version = "0.5.1";
      sha256 = "90bde5296fc891b0cef12a6d03ddccc162ce7b2aff54160af9338f8d40df6d19";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "getrandom" ]
      [ "std" ]
    ];
    dependencies = {
      getrandom = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_hc."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rand_hc";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_hc";
      version = "0.2.0";
      sha256 = "ca3129af7b92a17112d59ad498c6f81eaf463253766b90396d39ea7a39d6613c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "redox_syscall";
    version = "0.1.56";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "redox_syscall";
      version = "0.1.56";
      sha256 = "2439c63f3f6139d1b57529d16bc3b8bb855230c8efcc5d3a896c8bea7c3b1e84";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "regex";
    version = "1.3.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "regex";
      version = "1.3.1";
      sha256 = "dc220bd33bdce8f093101afe22a037b8eb0e5af33592e6a9caafff0d4cb81cbd";
    };
    features = builtins.concatLists [
      [ "aho-corasick" ]
      [ "default" ]
      [ "memchr" ]
      [ "perf" ]
      [ "perf-cache" ]
      [ "perf-dfa" ]
      [ "perf-inline" ]
      [ "perf-literal" ]
      [ "std" ]
      [ "thread_local" ]
      [ "unicode" ]
      [ "unicode-age" ]
      [ "unicode-bool" ]
      [ "unicode-case" ]
      [ "unicode-gencat" ]
      [ "unicode-perl" ]
      [ "unicode-script" ]
      [ "unicode-segment" ]
    ];
    dependencies = {
      aho_corasick = rustPackages."registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" { inherit profileName; };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { inherit profileName; };
      regex_syntax = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex-syntax."0.6.12" { inherit profileName; };
      thread_local = rustPackages."registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".regex-syntax."0.6.12" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "regex-syntax";
    version = "0.6.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "regex-syntax";
      version = "0.6.12";
      sha256 = "11a7e20d1cce64ef2fed88b66d347f88bd9babb82845b2b858f3edbf59a4f716";
    };
    features = builtins.concatLists [
      [ "unicode-age" ]
      [ "unicode-bool" ]
      [ "unicode-case" ]
      [ "unicode-gencat" ]
      [ "unicode-perl" ]
      [ "unicode-script" ]
      [ "unicode-segment" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".remove_dir_all."0.5.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "remove_dir_all";
    version = "0.5.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "remove_dir_all";
      version = "0.5.2";
      sha256 = "4a83fa3702a688b9359eccba92d153ac33fd2e8462f9e0e3fdf155239ea7792e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc-demangle."0.1.16" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rustc-demangle";
    version = "0.1.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc-demangle";
      version = "0.1.16";
      sha256 = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc-workspace-hack."1.0.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rustc-workspace-hack";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc-workspace-hack";
      version = "1.0.0";
      sha256 = "fc71d2faa173b74b232dedc235e3ee1696581bb132fc116fa3626d6151a1a8fb";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc_version."0.2.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rustc_version";
    version = "0.2.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc_version";
      version = "0.2.3";
      sha256 = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      semver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rustfix."0.4.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "rustfix";
    version = "0.4.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustfix";
      version = "0.4.6";
      sha256 = "7150ac777a2931a53489f5a41eb0937b84e3092a20cd0e73ad436b65b507f607";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { inherit profileName; };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "ryu";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ryu";
      version = "1.0.2";
      sha256 = "bfa8506c1de11c9c4e4c38863ccbe02a305c8188e85a05a784c9e11e1c3910c8";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "same-file";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "same-file";
      version = "1.0.5";
      sha256 = "585e8ddcedc187886a30fa705c47985c3fa88d06624095856b36ca0b82ff4421";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".schannel."0.1.16" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "schannel";
    version = "0.1.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "schannel";
      version = "0.1.16";
      sha256 = "87f550b06b6cba9c8b8be3ee73f391990116bf527450d2556e9b9ce263b9a021";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".scopeguard."0.3.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "scopeguard";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "scopeguard";
      version = "0.3.3";
      sha256 = "94258f53601af11e6a49f722422f6e3425c52b06245a5cf9bc09908b174f5e27";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "use_std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "semver";
    version = "0.9.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "semver";
      version = "0.9.0";
      sha256 = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "serde" ]
    ];
    dependencies = {
      semver_parser = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver-parser."0.7.0" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".semver-parser."0.7.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "semver-parser";
    version = "0.7.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "semver-parser";
      version = "0.7.0";
      sha256 = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "serde";
    version = "1.0.101";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde";
      version = "1.0.101";
      sha256 = "9796c9b7ba2ffe7a9ce53c2287dfc48080f4b2b362fcc245a259b3a7201119dd";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "derive" ]
      [ "serde_derive" ]
      [ "std" ]
    ];
    dependencies = {
      serde_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" { profileName = "__noProfile"; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "serde_derive";
    version = "1.0.101";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_derive";
      version = "1.0.101";
      sha256 = "4b133a43a1ecd55d4086bd5b4dc6c1751c68b1bfbeba7a5040442022c7e7c02e";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { inherit profileName; };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { inherit profileName; };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_ignored."0.0.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "serde_ignored";
    version = "0.0.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_ignored";
      version = "0.0.4";
      sha256 = "190e9765dcedb56be63b6e0993a006c7e3b071a016a304736e4a315dc01fb142";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "serde_json";
    version = "1.0.41";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_json";
      version = "1.0.41";
      sha256 = "2f72eb2a68a7dc3f9a691bfda9305a1c017a6215e5a4545c258500d2099a37c2";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "raw_value" ]
    ];
    dependencies = {
      itoa = rustPackages."registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" { inherit profileName; };
      ryu = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.2" { inherit profileName; };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".shell-escape."0.1.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "shell-escape";
    version = "0.1.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "shell-escape";
      version = "0.1.4";
      sha256 = "170a13e64f2a51b77a45702ba77287f5c6829375b04a69cf2222acd17d0cfab9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".sized-chunks."0.3.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "sized-chunks";
    version = "0.3.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "sized-chunks";
      version = "0.3.1";
      sha256 = "f01db57d7ee89c8e053245deb77040a6cc8508311f381c88749c33d4b9b78785";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      typenum = rustPackages."registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".smallvec."0.6.10" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "smallvec";
    version = "0.6.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "smallvec";
      version = "0.6.10";
      sha256 = "ab606a9c5e214920bb66c458cd7be8ef094f813f20fe77a54cc7dbfff220d4b7";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "socket2";
    version = "0.3.11";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "socket2";
      version = "0.3.11";
      sha256 = "e8b74de517221a2cb01a53349cf54182acdc31a074727d3079068448c0676d85";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "cfg_if" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".strip-ansi-escapes."0.1.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "strip-ansi-escapes";
    version = "0.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "strip-ansi-escapes";
      version = "0.1.0";
      sha256 = "9d63676e2abafa709460982ddc02a3bb586b6d15a49b75c212e06edd3933acee";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      vte = rustPackages."registry+https://github.com/rust-lang/crates.io-index".vte."0.3.3" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".strsim."0.8.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "strsim";
    version = "0.8.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "strsim";
      version = "0.8.0";
      sha256 = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "syn";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "syn";
      version = "1.0.5";
      sha256 = "66850e97125af79138385e9b88339cbcd037e3f28ceab8c5ad98e64f0f1f80bf";
    };
    features = builtins.concatLists [
      [ "clone-impls" ]
      [ "default" ]
      [ "derive" ]
      [ "extra-traits" ]
      [ "parsing" ]
      [ "printing" ]
      [ "proc-macro" ]
      [ "quote" ]
      [ "visit" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { inherit profileName; };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { inherit profileName; };
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".synstructure."0.12.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "synstructure";
    version = "0.12.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "synstructure";
      version = "0.12.1";
      sha256 = "3f085a5855930c0441ca1288cf044ea4aecf4f43a91668abdb870b4ba546a203";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { inherit profileName; };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { inherit profileName; };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { inherit profileName; };
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".tar."0.4.26" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "tar";
    version = "0.4.26";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "tar";
      version = "0.4.26";
      sha256 = "b3196bfbffbba3e57481b6ea32249fbaf590396a52505a2615adbb79d9d826d3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      filetime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" { inherit profileName; };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".tempfile."3.1.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "tempfile";
    version = "3.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "tempfile";
      version = "3.1.0";
      sha256 = "7a6e24d9338a0a5be79593e2fa15a648add6138caa803e2d5bc782c371732ca9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { inherit profileName; };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { inherit profileName; };
      rand = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand."0.7.2" { inherit profileName; };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { inherit profileName; };
      remove_dir_all = rustPackages."registry+https://github.com/rust-lang/crates.io-index".remove_dir_all."0.5.2" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "termcolor";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "termcolor";
      version = "1.0.5";
      sha256 = "96d6098003bde162e4277c70665bd87c326f5a0c3f3fbfb285787fa482d54e6e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "wincolor" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".wincolor."1.0.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".textwrap."0.11.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "textwrap";
    version = "0.11.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "textwrap";
      version = "0.11.0";
      sha256 = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "thread_local";
    version = "0.3.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "thread_local";
      version = "0.3.6";
      sha256 = "c6b53e329000edc2b34dbe8545fd20e55a333362d0a321909685a19bd28c3f1b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "toml";
    version = "0.5.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "toml";
      version = "0.5.3";
      sha256 = "c7aabe75941d914b72bf3e5d3932ed92ce0664d49d8432305a8b547c37227724";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "typenum";
    version = "1.11.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "typenum";
      version = "1.11.2";
      sha256 = "6d2783fe2d6b8c1101136184eb41be8b1ad379e4657050b8aaff0c79ee7575f9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "unicode-bidi";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-bidi";
      version = "0.3.4";
      sha256 = "49f2bd0c6468a8230e1db229cff8029217cf623c767ea5d60bfbd42729ea54d5";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "unicode-normalization";
    version = "0.1.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-normalization";
      version = "0.1.8";
      sha256 = "141339a08b982d942be2ca06ff8b076563cbe223d1befd5450716790d44e2426";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      smallvec = rustPackages."registry+https://github.com/rust-lang/crates.io-index".smallvec."0.6.10" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "unicode-width";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-width";
      version = "0.1.6";
      sha256 = "7007dbd421b92cc6e28410fe7362e2e0a2503394908f417b68ec8d1c364c4e20";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "unicode-xid";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-xid";
      version = "0.2.0";
      sha256 = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "url";
    version = "1.7.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url";
      version = "1.7.2";
      sha256 = "dd4e7c0d531266369519a4aa4f399d748bd37043b00bde1e4ff1f60a120b355a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      idna = rustPackages."registry+https://github.com/rust-lang/crates.io-index".idna."0.1.5" { inherit profileName; };
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { inherit profileName; };
      percent_encoding = rustPackages."registry+https://github.com/rust-lang/crates.io-index".percent-encoding."1.0.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "url";
    version = "2.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url";
      version = "2.1.0";
      sha256 = "75b414f6c464c879d7f9babf951f23bc3743fb7313c081b2e6ca719067ea9d61";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      idna = rustPackages."registry+https://github.com/rust-lang/crates.io-index".idna."0.2.0" { inherit profileName; };
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { inherit profileName; };
      percent_encoding = rustPackages."registry+https://github.com/rust-lang/crates.io-index".percent-encoding."2.1.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".url_serde."0.2.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "url_serde";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url_serde";
      version = "0.2.0";
      sha256 = "74e7d099f1ee52f823d4bdd60c93c3602043c728f5db3b97bdb548467f7bddea";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { inherit profileName; };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".utf8parse."0.1.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "utf8parse";
    version = "0.1.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "utf8parse";
      version = "0.1.1";
      sha256 = "8772a4ccbb4e89959023bc5b7cb8623a795caa7092d99f3aa9501b9484d4557d";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "vcpkg";
    version = "0.2.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vcpkg";
      version = "0.2.7";
      sha256 = "33dd455d0f96e90a75803cfeb7f948768c08d70a6de9a8d2362461935698bf95";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".vec_map."0.8.1" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "vec_map";
    version = "0.8.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vec_map";
      version = "0.8.1";
      sha256 = "05c78687fb1a80548ae3250346c3db86a80a7cdd77bda190189f2d0a0987c81a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".vte."0.3.3" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "vte";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vte";
      version = "0.3.3";
      sha256 = "4f42f536e22f7fcbb407639765c8fd78707a33109301f834a594758bedd6e8cf";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      utf8parse = rustPackages."registry+https://github.com/rust-lang/crates.io-index".utf8parse."0.1.1" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "walkdir";
    version = "2.2.9";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "walkdir";
      version = "2.2.9";
      sha256 = "9658c94fa8b940eab2250bd5a457f9c48b748420d71293b165c8cdbe2f55f71e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".wasi."0.7.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "wasi";
    version = "0.7.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "wasi";
      version = "0.7.0";
      sha256 = "b89c3ce4ce14bdc6fb6beaf9ec7928ca331de5df7e5ea278375642a2f478570d";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "winapi";
    version = "0.3.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi";
      version = "0.3.8";
      sha256 = "8093091eeb260906a183e6ae1abdba2ef5ef2257a21801128899c3fc699229c6";
    };
    features = builtins.concatLists [
      [ "basetsd" ]
      [ "consoleapi" ]
      [ "errhandlingapi" ]
      [ "fileapi" ]
      [ "handleapi" ]
      [ "ioapiset" ]
      [ "jobapi" ]
      [ "jobapi2" ]
      [ "libloaderapi" ]
      [ "lmcons" ]
      [ "memoryapi" ]
      [ "minschannel" ]
      [ "minwinbase" ]
      [ "minwindef" ]
      [ "namedpipeapi" ]
      [ "ntdef" ]
      [ "ntstatus" ]
      [ "processenv" ]
      [ "processthreadsapi" ]
      [ "psapi" ]
      [ "schannel" ]
      [ "securitybaseapi" ]
      [ "shellapi" ]
      [ "sspi" ]
      [ "std" ]
      [ "synchapi" ]
      [ "sysinfoapi" ]
      [ "timezoneapi" ]
      [ "userenv" ]
      [ "winbase" ]
      [ "wincon" ]
      [ "wincrypt" ]
      [ "winerror" ]
      [ "winnt" ]
      [ "winsock2" ]
      [ "ws2def" ]
      [ "ws2ipdef" ]
      [ "ws2tcpip" ]
    ];
    dependencies = {
      ${ if hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" || hostPlatform.config == "i686-pc-windows-gnu" then "winapi_i686_pc_windows_gnu" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-i686-pc-windows-gnu."0.4.0" { inherit profileName; };
      ${ if hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" || hostPlatform.config == "x86_64-pc-windows-gnu" then "winapi_x86_64_pc_windows_gnu" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-x86_64-pc-windows-gnu."0.4.0" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-i686-pc-windows-gnu."0.4.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-i686-pc-windows-gnu";
      version = "0.4.0";
      sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "winapi-util";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-util";
      version = "0.1.2";
      sha256 = "7168bab6e1daee33b4557efd0e95d5ca70a03706d39fa5f3fe7a236f584b03c9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-x86_64-pc-windows-gnu."0.4.0" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-x86_64-pc-windows-gnu";
      version = "0.4.0";
      sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".wincolor."1.0.2" = overridableMkRustCrate ({ profileName, profile }: {
    inherit release profile;
    name = "wincolor";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "wincolor";
      version = "1.0.2";
      sha256 = "96f5016b18804d24db43cebf3c77269e7569b8954a8464501c216cc5e070eaa9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { inherit profileName; };
      winapi_util = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { inherit profileName; };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
  });
  
}

