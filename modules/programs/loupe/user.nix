{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.loupe.user;
in {
  options.modules.programs.loupe.user.enable = mkEnableOption "Loupe image viewer";

  config = mkIf cfg.enable {
    home.packages = [pkgs.loupe];
  };
}
