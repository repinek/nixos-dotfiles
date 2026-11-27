{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.cli.zellij.user;
  mkHiddenDesktopFile = import ../../../lib/mkHiddenDesktopFile.nix;
in {
  options.modules.cli.zellij.user.enable = mkEnableOption "Zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      # enableFishIntegration = true;

      settings = {
        theme = "noctalia";

        show_startup_tips = false;
      };
    };

    xdg.dataFile = mkHiddenDesktopFile "dev.zellij.Zellij.desktop" "Zellij";
  };
}
