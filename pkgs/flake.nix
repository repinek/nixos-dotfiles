{
  description = "repinek's Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    supportedSystems = [
      "x86_64-linux"
    ];

    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
          };
        });
  in {
    packages = forEachSupportedSystem ({pkgs}: {
      ida-pro = pkgs.callPackage ./ida-pro {};
    });

    overlays.default = final: _: {
      ida-pro = final.callPackage ./ida-pro {};
    };
  };
}
