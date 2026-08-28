{
  config,
  lib,
  pkgs,
  ...
}: with lib;
let 
  cfg = config.modules.programs.anki.user;
in {
  options.modules.programs.anki.user.enable = mkEnableOption "Anki";

  config = mkIf cfg.enable {
    programs.anki = {
      enable = true;

      language = "en_GB";

      reduceMotion = true;
      uiScale = 1.4;

      addons = [
        pkgs.ankiAddons.review-heatmap
      ];

      # FIXME: secrets
      profiles."repinek" = {
        default = true;

        sync = {
          autoSync = true;
        };
      };
    };
  };
}
