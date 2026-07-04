{inputs, ...}: {
  host,
  hostname ? host,
  username ? hostname,
  system ? "x86_64-linux",
  modules ? [],
  users ? [],
  homeModules ? {},
  overlays ? [],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  modules =
    [
      # Add inputs, hostname and system in args for all modules
      {
        _module.args = {inherit inputs hostname system username;} // inputs;
        nixpkgs.overlays = overlays;
      }

      # Add home-manager
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = {inherit inputs hostname username;};
        };
      }

      # Import host
      ../hosts/${host}
    ]
    # For every user create home-manager with imports
    # Auto import user home.nix and system.nix
    ++ builtins.concatMap (username: [
      ../users/${username}/system.nix
      {
        home-manager.users.${username}.imports =
          [
            ../users/${username}/home.nix
          ]
          ++ (homeModules.${username} or []);
      }
    ])
    users
    # Add extra modules from args
    ++ modules;
}
