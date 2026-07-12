_: {
  wayland.windowManager.hyprland.settings = {
    # Get theme from noctalia
    source = "~/.config/hypr/noctalia.conf";

    general = {
      layout = "dwindle";

      gaps_in = 5;
      gaps_out = 10;

      border_size = 2;

      allow_tearing = true;
    };

    decoration = {
      rounding = 10;
      rounding_power = 2;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        # color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 3;

        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        # NAME            X0    Y0    X1    X2
        "easeOutQuint,    0.23, 1,    0.32, 1"
        "easeInOutCubic,  0.65, 0.05, 0.36, 1"
        "linear,          0,    0,    1,    1"
        "almostLinear,    0.5,  0.5,  0.75, 1"
        "quick,           0.15, 0,    0.1,  1"
      ];

      animation = [
        # NAME        ONOFF SPEED CURVE         STYLE
        "global,        1,  10,   default"
        "border,        1,  5.39, easeOutQuint"
        "windows,       1,  4.79, easeOutQuint"
        "windowsIn,     1,  4.1,  easeOutQuint, popin 87%"
        "windowsOut,    1,  1.49, linear,       popin 87%"
        "fadeIn,        1,  1.73, almostLinear"
        "fadeOut,       1,  1.46, almostLinear"
        "fade,          1,  3.03, quick"
        "layers,        1,  3.81, easeOutQuint"
        "layersIn,      1,  4,    easeOutQuint, fade"
        "layersOut,     1,  1.5,  linear,       fade"
        "fadeLayersIn,  1,  1.79, almostLinear"
        "fadeLayersOut, 1,  1.39, almostLinear"
        "workspaces,    1,  3,    quick,        fade"
        "workspacesIn,  1,  3,    quick,        fade"
        "workspacesOut, 1,  3,    quick,        fade"
      ];
    };

    dwindle = {
      preserve_split = true;
      special_scale_factor = 0.9; # On scratchpad
    };

    misc = {
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      focus_on_activate = true;
      vrr = 0; # 0 off, 1 on, 2 fullscreen only, 3 fullscreen video or game
    };
  };
}
