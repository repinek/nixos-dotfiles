{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Classic 20"
      "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
      "${lib.getExe pkgs.throne} -tray"
    ];
  };
}
