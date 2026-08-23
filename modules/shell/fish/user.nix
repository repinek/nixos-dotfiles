{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.fish.user;
  shellAliases = import ./fish-aliases.nix;
in {
  options.modules.shell.fish.user.enable = mkEnableOption "Fish config";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      inherit shellAliases;

      functions = {
        # Run Fastfetch as the greeting
        fish_greeting = "fastfetch";
      };
    };

    xdg.configFile."fish/functions/tl.fish".source = ./functions/tl.fish;
  };
}
