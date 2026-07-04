{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.system;
in {
  imports = [
    ./hyprpicker.nix
    ./portals.nix
  ];

  options.modules.desktop.hypr.system.enable = mkEnableOption "Hyprland ecosystem";

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    modules.desktop.hypr.hyprpicker.enable = true;
    modules.desktop.hypr.portals.enable = true;
  };
}
