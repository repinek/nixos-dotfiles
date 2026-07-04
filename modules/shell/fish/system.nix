{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.fish.system;
in {
  options.modules.shell.fish.system.enable = mkEnableOption "Fish shell";

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    # It's better to keep bash
    environment.shells = mkDefault [pkgs.bashInteractive pkgs.fish];
    users.defaultUserShell = mkForce pkgs.fish;
  };
}
