{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.losslesscut.user;
in {
  options.modules.programs.losslesscut.user.enable = mkEnableOption "LosslessCut";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.losslesscut
    ];
  };
}
