{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.user;
in {
  options.modules.desktop.hypr.user = {
    enable = mkEnableOption "Hyprland user config";
    hyprshot.enable = mkEnableOption "Hyprshot";
    hyprpicker.enable = mkEnableOption "Hyprpicker";
  };

  imports = [
    ./hyprland
  ];

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "hyprlang"; # FIXME: move to .lua
    };

    home.packages = with pkgs;
      []
      ++ optionals cfg.hyprshot.enable [hyprshot satty]
      ++ optionals cfg.hyprpicker.enable [hyprpicker wl-clipboard];
  };
}
