{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.loupe.system;
in {
  options.modules.programs.loupe.system.enable = mkEnableOption "Loupe D-Bus activation";

  config = mkIf cfg.enable {
    services.dbus.packages = [pkgs.loupe];
  };
}
