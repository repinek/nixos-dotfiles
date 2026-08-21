{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.nix-gc.system;
in {
  options.services.nix-gc.system.enable = mkEnableOption "Nix garbage collection and store optimisation";

  config = mkIf cfg.enable {
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };

    # Find identical files in store and hard-link them to each other
    nix.optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    # Save only 10 generations
    systemd.services.nix-gc.preStart = ''
      ${lib.getExe' config.nix.package "nix-env"} \
        --profile /nix/var/nix/profiles/system \
        --delete-generations +10
    '';
  };
}
