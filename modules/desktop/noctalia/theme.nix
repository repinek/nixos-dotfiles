{...}: {
  programs.noctalia.settings.theme = {
    # Default is catppuccin, but you can use whatever you want
    # Just change it in settings
    # NOTE: Don't use extract from wallpaper color pallete
    builtin = "Catppuccin";

    # source = "community";
    community_palette = "Lilac AMOLED";
    mode = "dark";

    # Also see template folder
    templates = {
      builtin_ids = ["alacritty" "btop" "hyprland" "gtk3" "gtk4" "qt"];
      community_ids = ["vscode" "discord"];
    };
  };
}
