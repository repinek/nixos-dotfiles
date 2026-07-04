{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.nix.system;
in {
  options.modules.core.nix.system.enable = mkEnableOption "Nix system settings";

  config = mkIf cfg.enable {
    # Set Nix latest version
    nix.package = pkgs.nixVersions.latest;

    # Disable channels, use flakes instead
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.channel.enable = false;

    nix.settings.trusted-users = ["root" "@wheel"];
    nix.settings.substituters = ["https://noctalia.cachix.org"];
    nix.settings.trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];

    nixpkgs.config.allowUnfree = mkForce true;

    # Nix garbage collector
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
