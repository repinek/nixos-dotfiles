{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git.user;
in {
  options.modules.cli.git.user = {
    enable = mkEnableOption "Git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        init.defaultBranch = "main";

        push = {
          autoSetupRemote = true; # Setup branch at remote if don't exist
          followTags = true; # Send tags too
        };

        pull.ff = "only"; # Use fast-forward - no merge commits

        rebase = {
          autoStash = true;
          autoSquash = true;
        };

        rerere.enabled = true; # reuse recorded resolution for merge conflicts

        help.autocorrect = 1; # You called y, which does not exist, we assume you meant x

        log.date = "relative";
        core.editor = "vim";
      };
    };
  };
}
