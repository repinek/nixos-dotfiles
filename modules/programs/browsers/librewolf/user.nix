{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.browsers.librewolf.user;
in {
  options.modules.programs.browsers.librewolf.user.enable = mkEnableOption "LibreWolf";

  config = mkIf cfg.enable {
    # This theme a little bit weird in some places
    # But overall it's good
    home.file.".librewolf/repinek/chrome".source = pkgs.zaps-cool-photon-theme;

    programs.librewolf = {
      enable = true;

      languagePacks = [
        "en-GB"
        "ru"
        "uk-UA"
      ];

      profiles.repinek = {
        id = 0;
        name = "repinek";
        isDefault = true;

        # TODO: make some extensions settings declarative
        extensions.packages = with inputs.firefox-addons.packages.x86_64-linux; [
          vimium
          ublock-origin
          darkreader
          proton-pass
          refined-github
          pywalfox
          # TODO:
          # oii (osu improvement indicator)
          # yomitan
          # asbplayer not sure if I needed it tho

          # I had foxyproxy before, but I don't use proxy anymore
          # Because I have vpn 24/7
          # Also I don't need any youtube extensions for now
          # Since I'm not watching youtube on pc
        ];

        # TODO: add bookmarks

        settings = {
          "intl.locale.requested" = "uk-UA,en-GB"; # Use fallback (second) language if localization is incomplete on first

          "extensions.autoDisableScopes" = 0; # Automatically enable extensions (from example)

          "browser.startup.page" = 3; # Open previous windows and tabs
          "browser.sessionstore.newTabOnRestore" = true; # Also open a new tab
          "browser.settings-redesign.promo.dismissed" = true;
          "browser.toolbars.bookmarks.visibility" = "never"; # TODO: for now
          # TODO: add uiCustomization, imperative for now

          "layout.css.devPixelsPerPx" = 1.2;
          "layout.css.prefers-color-scheme.content-override" = 0; # Dark theme

          "privacy.resistFingerprinting" = false;
          "privacy.sanitize.sanitizeOnShutdown" = false;

          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;

          # required by photon theme
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.newtabpage.activity-stream.logowordmark.alwaysVisible" = false;
          "browser.urlbar.scotchBonnet.enableOverride" = false;
          "widget.windows.mica.popups" = 0;
          "uc.librewolf" = true;
        };

        search = {
          default = "ddg";
          force = true;

          # TODO: add github
          engines = {
            # Taken from firefox example
            # Actually useful
            nix-packages = {
              name = "Nix packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            nixos-options = {
              name = "NixOS options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
              definedAliases = ["@no"];
            };

            nix-hm-options = {
              name = "Nix Home Manager options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "source";
                      value = "home_manager";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
              definedAliases = ["@nh"];
            };

            # Hide mojeek and startpage
            mojeek.metaData.hidden = true;
            startpage.metaData.hidden = true;
          };
        };
      };
    };
  };
}
