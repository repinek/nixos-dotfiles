{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.gnome-disk-utility.user;
in {
  options.modules.programs.gnome-disk-utility.user.enable = mkEnableOption "GNOME Disk Utility";

  config = mkIf cfg.enable {
    home.packages = [pkgs.gnome-disk-utility];
  };
}
