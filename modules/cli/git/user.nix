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

    # https://github.com/nix-community/home-manager/blob/165228b0efefc3e635e5174020c40ea64271dc25/modules/programs/git.nix
    signing = {
      key = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      format = mkOption {
        type = types.nullOr types.str;
        default = null;
      }; # In original there's enum instead str
      signByDefault = mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
    };

    user = {
      name = mkOption {type = types.str;};
      email = mkOption {type = types.str;};
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      signing = {
        key = cfg.signing.key;
        format = cfg.signing.format;
        signByDefault = cfg.signing.signByDefault;
      };

      settings = {
        user = {
          name = cfg.user.name;
          email = cfg.user.email;
        };

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
