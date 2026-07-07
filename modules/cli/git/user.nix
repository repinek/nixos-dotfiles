{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git.user;
in {
  options.modules.cli.git.user.enable = mkEnableOption "Git";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/HPg31ljATQIHzqtBIvsStdENH57A3CxgstnWnUlxg repinek";
        signByDefault = true;
      };
      settings = {
        user = {
          name = "repinek";
          email = "137826826+repinek@users.noreply.github.com";
        };

        gpg.format = "ssh";
  
        init = {
          defaultBranch = "main";
        };

        push = {
          autoSetupRemote = true; # Setup branch at remote if don't exist
        };

        pull = {
          ff = "only"; # Use fast-forward - no merge commits
        };
        
        rebase = {
          autoStash = true;
          autoSquash = true;
        };

        rerere.enabled = true;

        help.autocorrect = 0; # You called y, which does not exist, we assume you meant x

        log.date = "relative";
        core.editor = "vim";
      };
    };
  };
}
