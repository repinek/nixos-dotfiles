{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.security.system;
in {
  options.modules.core.security.system.enable = mkEnableOption "Security defaults";

  config = mkIf cfg.enable {
    security = {
      polkit.enable = true; # For controlling system-wide privileges
      sudo.keepTerminfo = true; # Keep terminal info while using sudo
    };
  };
}
