{
  pkgs,
  lib,
  username,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.btrfs.system;
in {
  options.modules.core.btrfs.system.enable = mkEnableOption "btrfs utilities";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btrfs-progs # Utilities for btrfs
      btrfs-list # tree-style view of btrfs things
      btrfs-assistant # GUI management tool
      # btbkp # btrfs backup TODO
    ];

    # FIXME: something wrong with btrfs subvolumes and move it to host specific place
    systemd.tmpfiles.rules = [
      "v /home/${username}/Media       0755 ${username} users - -"
      "v /home/${username}/Programming 0755 ${username} users - -"
      "v /home/${username}/Personal    0755 ${username} users - -"
      "v /home/${username}/Games       0755 ${username} users - -"
    ];
  };
}
