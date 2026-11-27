{config, ...}: {
  xdg.configFile."noctalia/avatar.png".source = ../../../assets/noctalia/avatar.png;

  # Well, some rules
  # - Colorize all icons
  # - No rounded corners
  # - Noctalia generates themes for almost all apps (using templates)
  # - No animations
  programs.noctalia.settings = {
    # omg why noctalia sometimes so weird
    # I wanted to sort it like in GUI, but not shows me what changed, so i guess let it be like this
    shell = {
      avatar_path = "${config.xdg.configHome}/noctalia/avatar.png";
      corner_radius_scale = 0;
      shadow.direction = "center";

      # I'm not sure which font I should use, for now let it be default
      # upd: since some version default is system default, not sans-serif, so back it
      font_family = "sans-serif";

      # Enable the systemd service so applications launched by Noctalia are not
      # terminated when the service restarts
      launch_apps_as_systemd_services = true;

      # Colorize icons
      screen_time_colorize_icons = true;
      polkit_colorize_icons = true;

      settings_show_advanced = true;
      settings_window_translucent = true;

      screen_time_enabled = true;
      external_ip_enabled = true; # Show external IP in the control center network tab

      time_format = "{:%H:%M:%S}";

      window_switcher = {
        colorize_icons = true;
      };

      panel = {
        open_near_click_control_center = true;
        open_near_click_session = true;
      };

      launcher = {
        layout = "simple";
        colorize_icons = true;
        categories = false;
        show_app_origin_indicator = false;
        compact = true;
        pinned = ["org.telegram.desktop"];
      };

      # R - Reboot, S - Shutdown, disable others
      session.actions = [
        {
          action = "lock";
          enabled = false;
          shortcut = "1";
        }
        {
          action = "logout";
          enabled = false;
          shortcut = "2";
        }
        {
          action = "lock_and_suspend";
          enabled = false;
          shortcut = "3";
        }
        {
          action = "reboot";
          enabled = true;
          shortcut = "R";
        }
        {
          action = "shutdown";
          enabled = true;
          shortcut = "S";
          variant = "destructive";
        }
      ];
    };

    theme = {
      # source = "community";
      builtin = "Rosé Pine";
      mode = "dark";

      templates = {
        builtin_ids = ["alacritty" "btop" "hyprland" "gtk3" "gtk4" "kcolorscheme" "qt"];
        community_ids = ["pywalfox-beta4" "discord" "obsidian" "vscode" "obs" "zed" "codex" "ungoogled-chromium" "neovim"];
      };
    };

    wallpaper = {
      fill_mpde = "crop";
      default.path = "${config.xdg.configHome}/noctalia/wallpaper/latest.png";

      transition = ["disc" "fade" "wipe"];
    };

    audio = {
      colorize_icons = true;
      enable_notification_sounds = false;
      enable_power_sounds = false;
      enable_screenshot_sounds = false;
      enable_sounds = false;
      enable_volume_sounds = false;
    };

    idle = {
      pre_action_fade_seconds = 0;

      # Lock after 5 minutes
      # Turn the screen off after 10
      # Disable suspend
      behavior_order = ["lock" "screen-off"];

      behavior = {
        lock = {
          action = "lock";
          enabled = true;
          timeout = 300.0;
        };
        "lock-and-suspend" = {
          action = "lock_and_suspend";
          enabled = false;
          timeout = 900.0;
        };
        "screen-off" = {
          action = "screen_off";
          enabled = true;
          timeout = 600.0;
        };
      };
    };

    location = {
      auto_locate = false; # a vpn makes automatic location unreliable

      # Used for weather and night light
      address = "Yekaterinburg, Russia";
      latitude = 56.8355;
      longitude = 60.6061;
    };

    lockscreen = {
      transition = []; # Disable all transitions
    };

    nightlight = {
      enabled = true;
      temperature_night = 2200;
    };

    notification = {
      colorize_icons = true;
      history_retention_hours = 1;
    };

    osd = {
      background_opacity = 0.6; # Same as bar
      kinds = {
        # Don't show OSD for
        lock_keys = false; # Caps Lock, Num Lock, Scroll Lock
        nightlight = false;
      };
    };

    control_center = {
      # Maybe for laptops I will change it later
      sidebar = "full";
      width = 800;

      shortcuts = [];
    };

    widget = {
      # Left section
      clock = {
        format = "{:%d/%m %H:%M:%S}";
        tooltip_format = "{:%H:%M:%S %A, %d %B %Y}";
        capsule = true;
        capsule_opacity = 0.5;
        capsule_padding = 10;
        capsule_radius = 0;
      };

      workspaces = {
        empty_color = "shadow";
        occupied_color = "on_surface";
        style = "minimal";
      };

      privacy.hide_inactive = true;

      # Center section
      active_window = {
        colorize_icons = true;
        title_scroll = "on_hover";
        max_length = 600;
      };

      # Left section
      tray.colorize_icons = true;
      taskbar.colorize_icons = true;
      media = {
        hide_when_no_media = true;
        max_length = 500;
        title_scroll = "always";
      };
    };

    # top is name
    bar.top = {
      font_family = "JetBrainsMono Nerd Font Mono";

      margin_edge = 0;
      margin_ends = 0;
      padding = 10;
      radius = 0;

      background_opacity = 0.6; # not sure, maybe set to 1
      scale = 1;
      thickness = 32;

      shadow = false;

      start = ["clock" "workspaces" "privacy"];
      center = ["active_window"];
      end = ["media" "group:g1" "keyboard_layout" "nightlight" "tray" "notifications" "session"];

      capsule_group = [
        {
          fill = "surface_container";
          id = "g1";
          members = ["network" "volume"];
          opacity = 0.5;
          padding = 10;
          radius = 0;
        }
      ];
    };
  }; # Noctalia ends here
}
