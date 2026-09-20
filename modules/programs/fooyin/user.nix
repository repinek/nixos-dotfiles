{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.fooyin.user;
in {
  options.modules.programs.fooyin.user.enable = mkEnableOption "Fooyin audio player";

  config = mkIf cfg.enable {
    home.packages = [pkgs.fooyin];
  };
}
