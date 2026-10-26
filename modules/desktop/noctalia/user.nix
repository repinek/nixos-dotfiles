{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.noctalia.user;
in {
  options.modules.desktop.noctalia.user.enable = mkEnableOption "Noctalia";

  imports = [
    ./audio.nix
    ./bar.nix
    ./control-center.nix
    ./idle.nix
    ./location.nix
    ./lockscreen.nix
    ./nightlight.nix
    ./notification.nix
    ./osd.nix
    ./shell.nix
    ./theme.nix
    ./widgets.nix
    ./wallpaper.nix
    ./templates/wallpaper.nix
    ./templates/fastfetch.nix
  ];

  config = mkIf cfg.enable {
    programs.noctalia = {
      enable = true;

      # Run as a systemd service
      systemd.enable = true;
    };

    xdg.dataFile."applications/dev.noctalia.Noctalia.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Noctalia
      Hidden=true
    '';
  };
}
