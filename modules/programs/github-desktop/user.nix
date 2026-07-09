{
  pkgs,
  config,
  lib,
  ...
}: with lib;
let 
  cfg = config.modules.programs.github-desktop.user;
in {
  options.modules.programs.github-desktop.user.enable = mkEnableOption "Github Desktop";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.github-desktop
    ];
  };
}
