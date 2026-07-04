{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class osu!, immediate yes" # For tearing

      "match:class waterfox, workspace 1 silent"

      "match:class org.telegram.desktop, workspace 2 silent"
    ];
  };
}
