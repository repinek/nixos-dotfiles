_: {
  programs.noctalia.settings.theme.templates.user.fastfetch = {
    input_path = "templates/fastfetch.jsonc";
    output_path = "~/.config/fastfetch/config.jsonc";
  };

  xdg.configFile."noctalia/templates/fastfetch.jsonc".source =
    ../../../cli/fastfetch/config.jsonc;
}
