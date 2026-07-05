{ hostname, ...}: {
  wayland.windowManager.hyprland.settings = {
    "$fileManager" = "nemo";
    "$terminal" = "alacritty";
    "$browser" = "waterfox";

    # Screenshots
    "$hyprpicker" = "hyprpicker --autocopy --no-fancy --render-inactive --scale=8";

    "$screenshotDir"   = "/home/${hostname}/Media/Screenshots/$(date +%Y-%m)";
    "$screenshotName"  = "Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png";
    "$mkdirScreenshot" = "mkdir -p $screenshotDir";
    "$hyprshotRegion"  = "$mkdirScreenshot && hyprshot --freeze --mode region --output-folder $screenshotDir --filename $screenshotName";
    "$hyprshotSatty"   = "$mkdirScreenshot && hyprshot --freeze --mode region --raw | satty --filename - --output-filename $screenshotDir/$screenshotName";
    "$hyprshotFull"    = "$mkdirScreenshot && hyprshot --freeze --mode output --mode DP-3 --output-folder $screenshotDir --filename $screenshotName"; # FIXME: remove hardcode
  };
}
