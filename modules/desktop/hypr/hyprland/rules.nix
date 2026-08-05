_: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class osu!, immediate true" # Allow tearing

      "match:class waterfox, workspace 1 silent"

      "match:class org.telegram.desktop, workspace 2 silent"

      # Run OBS Studio silently on magic workspace, set float, size 1200 700 and center it
      "match:class com.obsproject.Studio, workspace special:magic silent"
      "match:class com.obsproject.Studio, float true"
      "match:class com.obsproject.Studio, size 1200 700"
      "match:class com.obsproject.Studio, center true"
    ];
  };
}
