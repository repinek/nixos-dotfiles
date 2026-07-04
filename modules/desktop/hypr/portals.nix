{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.portals;
in {
  options.modules.desktop.hypr.portals.enable = mkEnableOption "XDG Desktop Portals (Hyprland)";

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      configPackages = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
    };
  };
}
