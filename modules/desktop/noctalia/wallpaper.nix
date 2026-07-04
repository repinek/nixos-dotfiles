{config, ...}: let
  cfgDir = "${config.xdg.configHome}/noctalia/wallpaper";
in {
  programs.noctalia.settings.wallpaper = {
    # See template/wallpaper
    fill_mode = "crop";
    default.path = "${cfgDir}/latest.png";

    transition = ["disc" "fade" "wipe"];
  };
}
