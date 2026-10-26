_: {
  programs.noctalia.settings.theme = {
    # Catppuccin is the default, but any scheme can be used
    # Change it in settings
    # NOTE: Do not extract the color palette from the wallpaper
    builtin = "Catppuccin";

    # source = "community";
    community_palette = "Lilac AMOLED";
    mode = "dark";

    # See the templates directory as well
    templates = {
      builtin_ids = ["alacritty" "btop" "hyprland" "gtk3" "gtk4" "kcolorscheme" "qt"];
      community_ids = ["pywalfox-beta4" "discord" "obsidian" "vscode" "obs" "zed" "codex" "ungoogled-chromium"];
    };
  };
}
