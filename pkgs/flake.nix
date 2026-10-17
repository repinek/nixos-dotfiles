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
      google-sans = pkgs.callPackage ./google-sans {};
      ida-pro = pkgs.callPackage ./ida-pro {};
      ida-pro-mcp = pkgs.callPackage ./ida-pro-mcp {};
      il2cpp-inspector-redux = pkgs.callPackage ./il2cpp-inspector-redux {};
    });

    overlays.default = final: _: {
      google-sans = final.callPackage ./google-sans {};
      ida-pro = final.callPackage ./ida-pro {};
      ida-pro-mcp = final.callPackage ./ida-pro-mcp {};
      il2cpp-inspector-redux = final.callPackage ./il2cpp-inspector-redux {};
    };
  };
}
