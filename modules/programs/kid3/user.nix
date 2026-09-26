{
  pkgs,
  lib,
  config
}: with lib;
let 
  cfg = config.modules.programs.kid3.user;
in {
  options.modules.programs.kid3.user.enable = mkEnableOption "kid3";

  config = mkIf cfg.enable {
    home.packages = [pkgs.kid3];
  };
}
