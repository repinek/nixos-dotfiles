{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.desktop.noctalia.user.enable {
    xdg.configFile."noctalia/avatar.png".source = ../../../assets/noctalia/avatar.png;

    programs.noctalia.settings.shell = {
      avatar_path = "${config.xdg.configHome}/noctalia/avatar.png";
      # Restore the shell font default from before Noctalia 5.6 (AI)
      font_family = "sans-serif";

      # Enable the systemd service so applications launched by Noctalia are not
      # terminated when the service restarts
      launch_apps_as_systemd_services = true;

      screen_time_enabled = true; # I was used niri-screen-time before (vibecoded as I know, btw)
      settings_show_advanced = true;
      screen_time_colorize_icons = true;
      polkit_colorize_icons = true;
      window_switcher.colorize_icons = true;
      external_ip_enabled = true; # Show external IP in the control center network tab
      time_format = "{:%H:%M:%S}";

      shadow.direction = "center";

      corner_radius_scale = 0;

      panel = {
        open_near_click_control_center = true;
        open_near_click_session = true;
      };

      launcher = {
        colorize_icons = true;
        layout = "simple";
        categories = false;
        pinned = ["org.telegram.desktop"];
      };

      # L - Lock; R - Reboot; S - Shutdown
      session.actions = [
        {
          action = "lock";
          enabled = true;
          shortcut = "L";
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
  };
}
