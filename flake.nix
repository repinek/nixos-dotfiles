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

    # Programs
    # Pin obsidian for older version
    nixpkgs-obsidian = {
      url = "https://releases.nixos.org/nixos/unstable/nixos-26.11pre1097682.02c087f3fe67/nixexprs.tar.zst";
      flake = false;
    };

    repinek-pkgs = {
      url = "path:./pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    osu-lazer = {
      url = "github:repinek/osu-lazer-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      modules = [inputs.sops-nix.nixosModules.sops];
      homeModules.repinek = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.osu-lazer.homeManagerModules.osu-lazer
        ./hosts/desktop/home.nix
      ];
      overlays = [inputs.repinek-pkgs.overlays.default];
    };
  };
}
