{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.libreoffice.user;
in {
  options.modules.programs.libreoffice.user.enable = mkEnableOption "LibreOffice";

  config = mkIf cfg.enable {
    home.packages = [pkgs.libreoffice-qt6-fresh];
  };
}
