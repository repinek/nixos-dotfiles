{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.system;
in {
  options.modules.desktop.hypr.system.enable = mkEnableOption "Hyprland";

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    # xdg-portal enabled by default
  };
}
