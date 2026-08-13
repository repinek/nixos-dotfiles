{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.security.system;
in {
  options.modules.core.security.system.enable = mkEnableOption "Security";

  config = mkIf cfg.enable {
    security = {
      polkit.enable = true; # Control system-wide privileges
      sudo.keepTerminfo = true; # Preserve terminal information when using sudo
    };
  };
}
