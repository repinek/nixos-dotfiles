{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.packages.user;
in {
  # Put user-level packages here:
  # 1. Have home-manager
  # 2. CLI replacements
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
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      jq.enable = true; # CLI JSON
    };
  };
}
