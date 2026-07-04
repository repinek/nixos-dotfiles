{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.packages.user;
in {
  # FIXME: maybe reconfigure this a little bit???
  # idk honestly
  options.modules.core.packages.user.enable = mkEnableOption "Base user packages";

  config = mkIf cfg.enable {
    # Replaces aliased in fish
    home.packages = with pkgs; [
      trashy # Replace rm, there's no home-manager option
      libnotify
      nixd # Nix LSP
    ];

    programs = {
      # Replacements
      bat.enable = true; # cat
      eza.enable = true; # ls
      ripgrep.enable = true; # grep
      zoxide.enable = true; # ls

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      jq.enable = true; # CLI JSON
      fzf.enable = true;
    };
  };
}
