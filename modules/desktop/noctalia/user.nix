{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.noctalia.user;
  mkHiddenDesktopFile = import ../../../lib/mkHiddenDesktopFile.nix;
in {
  options.modules.desktop.noctalia.user.enable = mkEnableOption "Noctalia";

  imports = [
    ./settings.nix
    ./templates/wallpaper.nix
    ./templates/fastfetch.nix
  ];

  config = mkIf cfg.enable {
    programs.noctalia = {
      enable = true;

      # Run as a systemd service
      systemd.enable = true;
    };

    xdg.dataFile = mkHiddenDesktopFile "dev.noctalia.Noctalia.desktop" "Noctalia";
  };
}
