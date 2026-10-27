{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.media.audacity.user;
in {
  options.modules.programs.media.audacity.user.enable = mkEnableOption "Audacity";

  config = mkIf cfg.enable {
    home.packages = [pkgs.audacity];
  };
}
