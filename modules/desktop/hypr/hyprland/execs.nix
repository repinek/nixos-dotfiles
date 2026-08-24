{
  pkgs,
  lib,
}: [
  "hyprctl setcursor Bibata-Modern-Classic 20"
  "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
  "${lib.getExe pkgs.throne} -tray"
]
