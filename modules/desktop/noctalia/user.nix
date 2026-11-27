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

    xdg.dataFile."applications/dev.noctalia.Noctalia.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Noctalia
      Hidden=true
    '';
  };
}
