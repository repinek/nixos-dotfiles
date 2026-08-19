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

      # vaults.repinek.settings = {
      #   app = {
      #     vimMode = true;
      #   };

      #   hotkeys = {
      #     "markdown:add-metadata-property" = [];
      #     "workspace:close-window" = [];
      #   };
      # };
    };
  };
}
