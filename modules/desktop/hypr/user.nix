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
    enable = mkEnableOption "Hyprland";
    hyprshot.enable = mkEnableOption "Hyprshot - screenshot tool";
    hyprpicker.enable = mkEnableOption "Hyprpicker - color picker";
    monitors = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Monitors for Hyprland, e.g. \"DP-3, 2560x1440@165.0, 0x0, 1\"";
    };
  };

  imports = [
    ./hyprland
  ];

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "hyprlang"; # FIXME: move to .lua

      settings.monitors = cfg.monitors;
    };

    home.packages = with pkgs;
      optionals cfg.hyprshot.enable [hyprshot satty]
      ++ optionals cfg.hyprpicker.enable [hyprpicker wl-clipboard];
  };
}
