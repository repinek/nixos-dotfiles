{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.audacity.user;
in {
  options.modules.programs.audacity.user.enable = mkEnableOption "Audacity - sound editor with graphical UI";

  config = mkIf cfg.enable {
    home.packages = [pkgs.audacity];
  };
}
