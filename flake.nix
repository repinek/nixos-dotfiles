{
  description = "repinek's NixOS flake";

  inputs = {
    # System
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Programs
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };

    waterfox-bin = {
      url = "github:Hythera/nix-waterfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    repinek-pkgs.url = "path:./pkgs";

    osu-lazer = {
      url = "github:repinek/osu-lazer-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        statix # linter
        deadnix # dead code
        sops # secret management
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # mkNixos doing all magic for us
    nixosConfigurations.desktop = mkNixos {
      host = "desktop";
      username = "repinek";
      users = ["repinek"];
      homeModules.repinek = [
        inputs.sops-nix.homeManagerModules.sops
        ./hosts/desktop/home
      ];
      modules = [inputs.sops-nix.nixosModules.sops];
      overlays = [inputs.repinek-pkgs.overlays.default];
    };

    nixosConfigurations.t14sg3 = mkNixos {
      host = "t14sg3";
      username = "repinek";
      users = ["repinek"];
      homeModules.repinek = [
        inputs.sops-nix.homeManagerModules.sops
        ./hosts/t14sg3/home
      ];
      modules = [
        inputs.sops-nix.nixosModules.sops
        inputs.disko.nixosModules.disko
      ];
      overlays = [inputs.repinek-pkgs.overlays.default];
    };
  };
}
