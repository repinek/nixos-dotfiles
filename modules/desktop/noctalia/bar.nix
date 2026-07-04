{...}: {
  programs.noctalia.settings.bar = {
    Top = {
      font_family = "JetBrainsMono Nerd Font Mono";

      # Same as hyprland windows
      margin_ends = 10;
      padding = 10;
      radius = 10;

      border = "primary";
      background_opacity = 0.6;
      scale = 1;
      thickness = 32;

      start = ["clock" "workspaces" "privacy"];
      center = ["active_window"];
      end = ["media" "group:g1" "keyboard_layout" "nightlight" "tray" "notifications" "session"];

      capsule_group = [
        {
          fill = "surface_variant";
          id = "g1";
          members = ["network" "volume"];
          opacity = 0.5;
          padding = 10;
          radius = 8;
        }
      ];
    };
  };
}
