{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.obsidian.user;
in {
  options.modules.programs.obsidian.user.enable = mkEnableOption "Obsidian";

  config = mkIf cfg.enable {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        app = {
          vimMode = true; # :q!
          showLineNumber = true;
          alwaysUpdateLinks = true;
          attachmentFolderPath = ".attachments";
        };

        appearance.enabledCssSnippets = ["noctalia"];

        hotkeys = {
          "markdown:add-metadata-property" = [];
          "editor:toggle-comments" = [];
          "editor:toggle-checklist-status" = [];
          "editor:open-search" = [];
          "editor:save-file" = [];
          "switcher:open" = [];
          "editor:open-link-in-new-window" = [];
          "app:open-help" = [];
          "app:go-back" = [];
          "app:go-forward" = [];
          "editor:insert-link" = [];
        };
      };

     vaults."Personal/Obsidian".settings = {};
    };
  };
}
