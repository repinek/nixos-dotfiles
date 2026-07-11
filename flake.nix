{
  description = "repinek's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia shell
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };

    waterfox-bin = {
      url = "github:Hythera/nix-waterfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    repinek-pkgs.url = "path:./pkgs";
  };

  nixConfig = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkNixos = import ./lib/mkNixos.nix {inherit inputs;};

    legacyPackages = nixpkgs.legacyPackages.x86_64-linux;
  in {
    # Setup a dev shell
    devShells.x86_64-linux.default = legacyPackages.mkShell {
      packages = with legacyPackages; [
        alejandra # formatter
        # statix
        deadnix # Find dead code
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # mkNixos doing all magic for us
    nixosConfigurations.desktop = mkNixos {
      host = "desktop";
      hostname = "repinek";
      username = "repinek";
      users = ["repinek"];
      homeModules.repinek = [./hosts/desktop/home];
      modules = [];
      overlays = [ inputs.repinek-pkgs.overlays.default ];
    };
  };
}
