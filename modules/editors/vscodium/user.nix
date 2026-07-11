{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.vscodium.user;
in {
  options.modules.editors.vscodium.user.enable = mkEnableOption "VSCodium";

  config = mkIf cfg.enable {
    programs.vscodium = {
      enable = true;
      # package = pkgs.vscodium-fhs; # Use wrapped variant in FHS environment UPD: I don't think we need it rn
      mutableExtensionsDir = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          # Themes
          catppuccin.catppuccin-vsc
          mvllow.rose-pine
          # FIXME: Unavailable in vscode-extensions
          # noctalia.noctaliatheme # https://open-vsx.org/extension/Noctalia/noctaliatheme
          # daitsuku.cherry-blossom-vscode-theme # https://open-vsx.org/extension/daitsuku/cherry-blossom-vscode-theme

          # Other
          esbenp.prettier-vscode
          jnoortheen.nix-ide
          usernamehw.errorlens
          dbaeumer.vscode-eslint
          vscodevim.vim
        ];

        userSettings = {
          "editor.fontSize" = 16;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', monospace";
          "editor.fontLigatures" = true; # ==, != and this stuff
          "editor.wordWrap" = "on";
          "editor.mouseWheelZoom" = true;

          "workbench.colorTheme" = "Cherry Blossom Dimmed";
          "workbench.startupEditor" = "none";

          # QoL
          "editor.minimap.enabled" = false;
          "editor.linkedEditing" = true;
          "editor.lineNumbers" = "relative"; # Since we are using VIM plugin

          # https://stackoverflow.com/questions/48044429/override-alt-to-toggle-menu-bar-on-vs-code
          "window.titleBarStyle" = "custom";
          "window.customMenuBarAltFocus" = false;

          # Cursor
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "explicit";

          # File saving
          "files.autoSave" = "onFocusChange";
          "files.insertFinalNewline" = true;

          # Formatter
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSave" = false;
          "editor.formatOnPaste" = false;

          # Terminal
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
          "terminal.integrated.smoothScrolling" = true;

          # Privacy
          "update.showReleaseNotes" = false;
          "telemetry.feedback.enabled" = false;
          "chat.agent.enabled" = false;
          "terminal.integrated.inheritEnv" = false;

          # Exclude dependencies and build outputs (Idk if these makes any sense)
          "search.exclude" = {
            "**/node_modules" = true;
            "**/dist" = true;
            "**/build" = true;
            "**/.git" = true;
          };

          "files.watcherExclude" = {
            "**/node_modules/**" = true;
            "**/dist/**" = true;
            "**/build/**" = true;
          };

          # VIM motions
          "vim.useSystemClipboard" = true;
          "vim.easymotion" = true;
          "vim.incsearch" = true;
          "vim.hlsearch" = true;

          "vim.insertModeKeyBindings" = [
            # jj to exit insert mode
            {
              "before" = ["j" "j"];
              "after" = ["<Esc>"];
            }
          ];

          # use jkl; instead hjkl
          "vim.normalModeKeyBindingsNonRecursive" = [
            {
              "before" = ["j"];
              "after" = ["h"];
            }
            {
              "before" = ["k"];
              "after" = ["j"];
            }
            {
              "before" = ["l"];
              "after" = ["k"];
            }
            {
              "before" = [";"];
              "after" = ["l"];
            }
            {
              "before" = ["h"];
              "after" = [";"];
            }
          ];
          "vim.visualModeKeyBindingsNonRecursive" = [
            {
              "before" = ["j"];
              "after" = ["h"];
            }
            {
              "before" = ["k"];
              "after" = ["j"];
            }
            {
              "before" = ["l"];
              "after" = ["k"];
            }
            {
              "before" = [";"];
              "after" = ["l"];
            }
            {
              "before" = ["h"];
              "after" = [";"];
            }
          ];
          "vim.operatorPendingModeKeyBindingsNonRecursive" = [
            {
              "before" = ["j"];
              "after" = ["h"];
            }
            {
              "before" = ["k"];
              "after" = ["j"];
            }
            {
              "before" = ["l"];
              "after" = ["k"];
            }
            {
              "before" = [";"];
              "after" = ["l"];
            }
            {
              "before" = ["h"];
              "after" = [";"];
            }
          ];

          # Nix Extension
          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = "alejandra";
        };
      };
    };
  };
}
