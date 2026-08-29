{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.vscodium.user;

  customExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # NoctaliaTheme
    {
      publisher = "Noctalia";
      name = "noctaliatheme";
      version = "0.0.5";
      hash = "sha256-aTSk3yYkBw5GrD0CbRL2wo3SlBffzBTDe1pZoZa1URQ=";
    }
    # Cherry Blossom Theme
    {
      publisher = "daitsuku";
      name = "cherry-blossom-vscode-theme";
      version = "1.2.1";
      hash = "sha256-FiwNQtlcqU0vILnsHkePWBmHaCsXjA5A0xz8Lg+osl0=";
    }
  ];
in {
  options.modules.editors.vscodium.user.enable = mkEnableOption "VSCodium";

  config = mkIf cfg.enable {
    programs.vscodium = {
      enable = true;
      # package = pkgs.vscodium-fhs; # Use the wrapped variant in an FHS environment if needed
      mutableExtensionsDir = true;

      profiles.default = {
        extensions =
          (with pkgs.vscode-extensions; [
            # Themes
            catppuccin.catppuccin-vsc # Catppuccin for VS Code
            mvllow.rose-pine # Rose Pine

            # Other
            esbenp.prettier-vscode # Prettier - code formatter
            jnoortheen.nix-ide # Nix IDE
            sumneko.lua # Lua
            usernamehw.errorlens # Error Lens
            dbaeumer.vscode-eslint # ESLint
            vscodevim.vim # Vim
          ])
          ++ customExtensions;

        userSettings = {
          "editor.fontSize" = 16;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', monospace";
          "editor.fontLigatures" = true; # ==, != and this stuff
          "editor.wordWrap" = "on";
          "editor.mouseWheelZoom" = true;

          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.startupEditor" = "none";
          "window.zoomLevel" = 2; # Approximately 144% (or two zoom-in steps)

          # Quality of life
          "editor.minimap.enabled" = false;
          "editor.linkedEditing" = true;
          "editor.lineNumbers" = "relative"; # Since we are using VIM plugin

          # https://stackoverflow.com/questions/48044429/override-alt-to-toggle-menu-bar-on-vs-code
          # Override Alt to toggle menu bar
          # It conflicts with Shift + Alt for switching keyboard layouts
          "window.titleBarStyle" = "custom";
          "window.customMenuBarAltFocus" = false;

          # Cursor
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "explicit";

          # File saving
          "files.autoSave" = "onFocusChange";
          "files.insertFinalNewline" = true;
          "files.associations"."*.lua" = "lua";

          # Formatter
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSave" = false;
          "editor.formatOnPaste" = false;

          # Terminal
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
          "terminal.integrated.smoothScrolling" = true;
          "terminal.integrated.stickyScroll.enabled" = false;

          # Privacy
          "update.showReleaseNotes" = false;
          "telemetry.feedback.enabled" = false;
          "chat.agent.enabled" = false;
          "terminal.integrated.inheritEnv" = false;

          # Exclude dependencies and build outputs
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
            # Use jj to exit insert mode
            {
              "before" = ["j" "j"];
              "after" = ["<Esc>"];
            }
          ];
          # Nix Extension
          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = "alejandra";

          # Lua Language Server
          # Stubs for hyprland
          "Lua.workspace.library" = [
            "${config.wayland.windowManager.hyprland.finalPackage}/share/hypr/stubs"
          ];
          "Lua.diagnostics.globals" = ["hl"];
        };
      };
    };
  };
}
