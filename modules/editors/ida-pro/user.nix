{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.ida-pro.user;
in {
  options.modules.editors.ida-pro.user.enable = mkEnableOption "IDA Pro 9.2";

  config = mkIf cfg.enable {
    home.packages = [pkgs.ida-pro];
  };
}
