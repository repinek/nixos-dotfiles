_: {
  programs.noctalia.settings.bar = {
    Top = {
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
          fill = "surface_variant";
          id = "g1";
          members = ["network" "volume"];
          opacity = 0.5;
          padding = 10;
          radius = 0;
        }
      ];
    };
  };
}
