{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.user;
in {
  options.modules.desktop.hypr.user.enable = mkEnableOption "Hyprland user config";

  imports = [
    ./hyprland
  ];

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "hyprlang"; # FIXME: move to .lua
    };
  };
}
