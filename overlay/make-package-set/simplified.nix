args@{
  pkgs,
  buildPackages,
  stdenv,
  rustBuilder,
  rustChannel,
  packageFun,
  rustPackageConfig ? _: { },
  ...
}:
let
  rustChannel = buildPackages.rustChannelOf {
    channel = "1.40.0";
  };
  inherit (rustChannel) cargo;
  rustc = rustChannel.rust.override {
    targets = [
      (rustBuilder.rustLib.realHostTriple stdenv.targetPlatform)
    ];
    extensions = [
      "rust-std"
      "rls-preview"
      "rust-analysis"
      "rustfmt-preview"
      "rust-src"
      "clippy-preview"
    ];
  };
  extraArgs = builtins.removeAttrs args [ "stdenv" "pkgs" "buildPackages" "rustBuilder" "rustChannel" "packageFun" "rustPackageConfig" ];
in
rustBuilder.makePackageSet (extraArgs // {
  inherit cargo rustc packageFun;
  rustPackageConfig = rustPackageConfig pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
      inherit cargo rustc packageFun;
      rustPackageConfig = rustPackageConfig buildPackages;
  });
})
