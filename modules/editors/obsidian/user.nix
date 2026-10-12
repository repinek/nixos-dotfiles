{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editors.obsidian.user;
in {
  options.modules.editors.obsidian.user.enable = mkEnableOption "Obsidian";

  config = mkIf cfg.enable {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        app = {
          vimMode = true; # :q!
          showLineNumber = true;
          alwaysUpdateLinks = true;
          attachmentFolderPath = "attachments";
        };

        appearance.enabledCssSnippets = ["noctalia"];

        hotkeys = {
          # Comments shows what is default
          "markdown:add-metadata-property" = []; # Ctrl + ;
          "editor:toggle-comments" = []; # Ctrl + /
          "editor:toggle-checklist-status" = []; # Ctrl + L
          "editor:open-search-replace" = []; # Ctrl + H 
          "editor:save-file" = []; # Ctrl + S
          "editor:insert-link" = []; # Ctrl + K
          "editor:delete-paragraph" = []; # Ctrl + D
          "editor:open-link-in-new-window" = []; # Ctrl + Alt + Shift + Enter (hello?)
          "insert-template" = [ 
            { 
            modifiers = [ "Mod" ]; # Mod is Ctrl
            key = "R";
            }
          ];
          "app:open-help" = []; # F1
          "app:go-back" = []; # Ctrl + Alt + <-
          "app:go-forward" = []; # Ctrl + Alt + ->
        };
      };
    };
  };
}
