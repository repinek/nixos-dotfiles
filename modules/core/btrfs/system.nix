{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.btrfs.system;
in {
  options.modules.core.btrfs.system.enable = mkEnableOption "Btrfs utilities";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btrfs-progs # Btrfs utilities
      btrfs-list # Tree-style Btrfs subvolume viewer
    ];
  };
}
