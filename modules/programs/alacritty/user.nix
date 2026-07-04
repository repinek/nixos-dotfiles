{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.alacritty.user;
in {
  options.modules.programs.alacritty.user.enable = mkEnableOption "Alacritty";

  config = mkIf cfg.enable {
    xdg.configFile."alacritty/alacritty.toml".force = true;

    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          padding = {
            x = 12;
            y = 12;
          };
          dynamic_padding = true;
          opacity = 0.8;
          blur = true;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          normal = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold Italic";
          };
          size = 11;
        };

        selection = {
          save_to_clipboard = true;
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
        };
      };
    };
  };
}
