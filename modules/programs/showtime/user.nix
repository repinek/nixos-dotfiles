{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.showtime.user;
in {
  options.modules.programs.showtime.user.enable = mkEnableOption "Showtime video player";

  config = mkIf cfg.enable {
    home.packages = [pkgs.showtime];
  };
}
