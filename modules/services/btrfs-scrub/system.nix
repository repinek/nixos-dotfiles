{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.btrfs-scrub.system;
in {
  options.modules.services.btrfs-scrub.system.enable = mkEnableOption "Btrfs scrub";

  config = mkIf cfg.enable {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/" "/mnt/Old"];
    };
  };
}
