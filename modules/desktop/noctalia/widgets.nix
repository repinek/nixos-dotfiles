{...}: {
  programs.noctalia.settings.widget = {
    # Start
    clock = {
      format = "{:%d/%m %H:%M:%S}";
      tooltip_format = "{:%H:%M:%S %A, %d %B %Y}";
      capsule = true;
      capsule_opacity = 0.5;
      capsule_padding = 10;
      capsule_radius = 8;
    };

    workspaces = {
      empty_color = "shadow";
      occupied_color = "shadow";
    };

    privacy.hide_inactive = true;

    # Center
    active_window = {
      title_scroll = "on_hover";
      max_length = 600;
    };

    # End
    media = {
      hide_when_no_media = true;
      max_length = 500;
      title_scroll = "always";
    };
  };
}
