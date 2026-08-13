{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.packages.user;
in {
  # Put user-level packages here when they:
  # 1. Have a Home Manager module
  # 2. Replace common CLI tools
  options.modules.core.packages.user.enable = mkEnableOption "Base user packages";

  config = mkIf cfg.enable {
    # Replaces commands aliased in Fish
    home.packages = with pkgs; [
      trashy # Replaces rm; no Home Manager module is available
      libnotify
      nixd # Nix LSP
    ];

    programs = {
      # Command replacements
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
