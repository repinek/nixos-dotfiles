{ 
  pkgs,
  lib,
  config,
  ...
}: with lib; 
let 
  cfg = config.modules.cli.gh.user;
in {
  options.modules.cli.gh.user.enable = mkEnableOption "Github CLI tool (gh)";

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      settings = {
        editor = "vim";
        git_protocol = "ssh";
      };
    };
  };
} 
