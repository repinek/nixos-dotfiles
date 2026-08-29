{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.showtime.system;
in {
  options.modules.programs.showtime.system.enable = mkEnableOption "Showtime D-Bus activation";

  config = mkIf cfg.enable {
    services.dbus.packages = [pkgs.showtime];
  };
}
