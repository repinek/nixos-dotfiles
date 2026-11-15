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

  # https://www.youtube.com/watch?v=VqJn058GWQg
  # very good video, good setup
  config = mkIf cfg.enable {
    programs.anki = {
      enable = true;

      language = "en_GB";

      reduceMotion = true;
      style = "native";

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

        # Buttons confirmation is very useful
        ((pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
          pname = "Anki-Advanced-Review-Bottombar";
          version = "3.6.1";
          src = pkgs.fetchFromGitHub {
            owner = "noobj2";
            repo = "Anki-Advanced-Review-Bottombar";
            rev = "7fd5c16090b5b7c0e2f26d040a6552680d29684c";
            hash = "sha256-ah51DWf1DbULF580hMj360R5qPh3fHnYM6KGBtJrgh8=";
          };
          sourceRoot = "${finalAttrs.src.name}";
        })).withConfig {
          config = {
            # This is real keys btw
            "Button_   Info Button" = false;
            "Button_   Skip Button" = false;
          };
        })
      ];
    };
  };
}
