{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.filelight.user;
in {
  options.modules.programs.filelight.user.enable = mkEnableOption "Filelight";

  config = mkIf cfg.enable {
    home.packages = [pkgs.kdePackages.filelight];
  };
}
