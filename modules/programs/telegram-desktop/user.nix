{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.telegram-desktop.user;
in {
  options.modules.programs.telegram-desktop.user.enable = mkEnableOption "telegram-desktop";

  config = mkIf cfg.enable {
    home.packages = [pkgs.telegram-desktop];
  };
}
