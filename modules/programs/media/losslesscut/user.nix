{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.media.losslesscut.user;
in {
  options.modules.programs.media.losslesscut.user.enable = mkEnableOption "LosslessCut";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.losslesscut
    ];
  };
}
