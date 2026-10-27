{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.media.fooyin.user;
in {
  options.modules.programs.media.fooyin.user.enable = mkEnableOption "Fooyin audio player";

  config = mkIf cfg.enable {
    home.packages = [pkgs.fooyin];
  };
}
