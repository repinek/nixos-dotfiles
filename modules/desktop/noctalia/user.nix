{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.noctalia.user;
in {
  options.modules.desktop.noctalia.user.enable = mkEnableOption "Noctalia shell";

  imports = [
    inputs.noctalia.homeModules.default
    ./bar.nix
    ./control-center.nix
    ./idle.nix
    ./location.nix
    ./lockscreen.nix
    ./nightlight.nix
    ./osd.nix
    ./screenshot.nix
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

      # Run as systemd service
      # systemd.enable = true;
    };
  };
}
