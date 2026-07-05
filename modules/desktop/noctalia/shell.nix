{config, ...}: {
  xdg.configFile."noctalia/avatar.png".source = ../../../assets/noctalia/avatar.png;

  programs.noctalia.settings.shell = {
    avatar_path = "${config.xdg.configHome}/noctalia/avatar.png";

    # We are using systemd service, so enable it
    # Otherwise any apps launched by Noctalia
    # Will be terminated when the service restarts
    launch_apps_as_systemd_services = true;

    screen_time_enabled = true; # I was used niri-screen-time before (vibecoded as I know, btw)
    settings_show_advanced = true;
    app_icon_colorize = true; # This is looks cool
    time_format = "{:%H:%M:%S}";

    shadow.direction = "center";

    panel = {
      open_near_click_control_center = true;
      open_near_click_session = true;
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
}
