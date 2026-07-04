{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.fish.user;
  shellAliases = import ./fish-aliases.nix;
in {
  options.modules.shell.fish.user.enable = mkEnableOption "Fish configuration";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      inherit shellAliases;

      # Run fastfetch as greeting
      functions = {
        fish_greeting = "fastfetch";
      };
    };
  };
}
