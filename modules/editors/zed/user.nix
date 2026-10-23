{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.zed.user;
in {
  options.modules.editors.zed.user.enable = mkEnableOption "Zed editor";

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;

      mutableUserSettings = true; # Just for changing themes

      extensions = [
        "nix" # Nix support
        "lua" # Lua support
        "catppuccin" # Catppuccin Theme
        "catppuccin-black-theme" # Catppuccin Black Theme
        "everforest" # Everforest Theme
        "wakatime" # WakaTime support
      ];

      # These keys so weird sometimes...
      userSettings = {
        # General
        telemetry = {
          diagnostics = false;
          metrics = false;
          anthropic_retention = false;
        };

        # Appearance
        theme = "Catppuccin Mocha";
        icon_theme = "Zed (Default)";

        buffer_font_family = "JetBrainsMono Nerd Font Mono";
        buffer_font_size = 16;
        buffer_font_features = {
          calt = true;
          liga = true;
        };

        ui_font_family = "JetBrainsMono Nerd Font Mono";
        ui_font_size = 16;
        ui_font_features = {
          calt = true;
          liga = true;
        };

        cursor_animation.enabled = true; # Why it's .enabled lol, kinda weird

        # Keymap
        vim_mode = true;
        vim.toggle_relative_line_numbers = true;
        soft_wrap = "editor_width";

        # Editor
        autosave = "on_focus_change";

        which_key = {
          enabled = true;
          delay_ms = 100;
        };
        # TODO add

        # Languages & Tools
        languages = {
          Nix.language_servers = [ "nixd" "!nil" ]; # Only use Nixd
          TypeScript.tab_size = 4;
          JavaScript.tab_size = 4;
        };

        lsp = {
          vtsls.settings = {
            typescript.updateImportsOnFileMove.enabled = "always";
            javascript.updateImportsOnFileMove.enabled = "always";
          };
          # Use alejandra as default formatter
          nixd.settings.formatting.command = ["alejandra" "--quiet" "--"];
          # Hyprland stubs
          lua-language-server.settings.Lua = {
            workspace.library = [
              "${config.wayland.windowManager.hyprland.finalPackage}/share/hypr/stubs"
            ];
            diagnostics.global = [ "hl" ];
          };
        };

        diagnostics.inline.enabled = true;

        # Window & Layout
        search.button = false;
        debugger.button = false;

        title_bar = {
          show_worktree_name = false;
          show_sign_in = false;
        };

        tabs = {
          git_status = true;
          file_icons = true;
          show_diagnostics = "errors";
        };

        tab_bar = {
          show_nav_history_buttons = true;
        };

        # Panels
        collaboration_panel.button = false;

        # Terminal
        terminal = {
          font_family = "JetBrainsMono Nerd Font Mono";
          font_size = 14;
        };

        # Version Control
        git = {
          inline_blame.location = "status_bar";
        };

        # AI
        disable_ai = true;
      };
    };
  };
}
