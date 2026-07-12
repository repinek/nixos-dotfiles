{
  pkgs,
  lib,
  config,
  ...
}: with lib;
let 
  cfg = config.modules.editors.opencode.user;
in {
  options.modules.editors.opencode.user.enable = mkEnableOption "opencode - AI coding agent";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.opencode ];
  };
}
