{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.fish.system;
in {
  options.modules.shell.fish.system.enable = mkEnableOption "Fish default shell";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      # home-manager override this settings
      # But still works for root
      # That's exactly what we need
      shellAliases = {
        "ls" = "ls -la";
      };

      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    # It's better to keep bash
    environment.shells = mkDefault [pkgs.bashInteractive pkgs.fish];
    users.defaultUserShell = mkForce pkgs.fish;
  };
}
