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
        pkgs.ankiAddons.crowdanki

        (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
          pname = "More_Decks_Stats_and_Time_Left";
          version = "2.9";
          src = pkgs.fetchFromGitHub {
            owner = "cjdduarte";
            repo = "MDS_Time_Left";
            rev = "4964216a1eaf03ec299ec2a3df1379108a9f9116";
            hash = "sha256-6Mi+JdbaabW2brxK8TEs7V+QU7h6EyNCixUcUbM4BOM=";
          };
          sourceRoot = "${finalAttrs.src.name}";
        }))
      ];
    };
  };
}
