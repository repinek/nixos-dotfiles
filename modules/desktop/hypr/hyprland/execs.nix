{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Classic 20"
      "noctalia"
      "${pkgs.throne}/bin/Throne -tray"
    ];
  };
}
