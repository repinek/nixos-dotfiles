{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.losslesscut.user;
in {
  options.modules.programs.losslesscut.user.enable = mkEnableOption "Lossless Cut";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.losslesscut
    ];
  };
}
