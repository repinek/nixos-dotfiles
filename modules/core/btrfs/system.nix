{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.btrfs.system;
in {
  options.modules.core.btrfs.system.enable = mkEnableOption "Btrfs - snapshots and maintenance tools";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btrfs-progs # Utilities for btrfs
      btrfs-list # tree-style view of btrfs things
      btrfs-assistant # GUI management tool
      # btbkp # btrfs backup TODO FIXME
    ];
  };
}
