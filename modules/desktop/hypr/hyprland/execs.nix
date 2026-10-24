{
  pkgs,
  lib,
}: [
  "hyprctl setcursor Bibata-Modern-Classic 20"
  "${lib.getExe pkgs.throne} -tray"
]
