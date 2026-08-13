{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.fish.system;
in {
  options.modules.shell.fish.system.enable = mkEnableOption "Fish as the default shell";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      # Home Manager overrides these settings for users, but they still apply to root
      shellAliases = {
        "ls" = "ls -la";
      };

      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    # Keep Bash available
    environment.shells = mkDefault [pkgs.bashInteractive pkgs.fish];
    users.defaultUserShell = mkForce pkgs.fish;
  };
}
