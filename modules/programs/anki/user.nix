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
    programs.anki = {
      enable = true;

      language = "en_GB";

      reduceMotion = true;
      uiScale = 1.4;

      addons = [
        pkgs.ankiAddons.review-heatmap
        
        (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
          pname = "CrowdAnki";
          version = "0.9.6";
          src = pkgs.fetchzip {
            url = "https://github.com/Stvad/CrowdAnki/releases/download/v${finalAttrs.version}/crowd_anki_20260918.zip";
            hash = "sha256-sL55PAa3qSzNsRoupIFTcqe7y/APlCW4G0SzPJFUR4U=";
            stripRoot = false;
          };
          sourceRoot = "${finalAttrs.src.name}";
        }))
      ];
    };
  };
}
