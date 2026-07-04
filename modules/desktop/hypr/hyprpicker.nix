{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.hyprpicker;
in {
  options.modules.desktop.hypr.hyprpicker.enable = mkEnableOption "Hyprpicker";

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.hyprpicker pkgs.wl-clipboard];
  };
}
