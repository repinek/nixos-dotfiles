{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.anki.user;
in {
  options.modules.programs.anki.user.enable = mkEnableOption "Anki";

  config = mkIf cfg.enable {
    sops.secrets."repinek/anki/username" = {};
    sops.secrets."repinek/anki/key" = {};

    programs.anki = {
      enable = true;

      language = "en_GB";

      reduceMotion = true;
      uiScale = 1.4;

      addons = [
        pkgs.ankiAddons.review-heatmap
      ];

      profiles."repinek" = {
        default = true;

        sync = {
          autoSync = true;
          usernameFile = config.sops.secrets."repinek/anki/username".path;
          keyFile = config.sops.secrets."repinek/anki/key".path;
        };
      };
    };
  };
}
