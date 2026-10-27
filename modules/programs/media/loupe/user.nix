{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.media.loupe.user;
in {
  options.modules.programs.media.loupe.user.enable = mkEnableOption "Loupe image viewer";

  config = mkIf cfg.enable {
    home.packages = [pkgs.loupe];
  };
}
