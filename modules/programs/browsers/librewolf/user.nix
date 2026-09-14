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
    # upd: vertical tabs are awful
    # I have no idea how to fix this, maybe check something other
    # like Firefox UI Fix (Lepton)
    # home.file.".librewolf/repinek/chrome".source = pkgs.zaps-cool-photon-theme;

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

        userChrome = ''
          #urlbar,
          #searchbar,
          #searchbar-new {
            --urlbar-inner-border-radius: 4px !important;
          }

          #urlbar-background,
          .urlbar-background,
          .urlbar-input-container,
          #searchbar,
          #tabbrowser-tabs[orient="vertical"] .tabbrowser-tab .tab-background,
          #tabbrowser-tabs[orient="vertical"] .tabbrowser-tab[pinned] .tab-content {
            border-radius: 4px !important;
          }

          #sidebar-main .buttons-wrapper,
          #sidebar-tools-and-extensions-splitter {
            display: none !important;
          }
        '';

        userContent = ''
          @-moz-document url("about:newtab"), url("about:home") {
            .search-handoff-button,
            #newtab-search-text {
              border-radius: 4px !important;
            }

            .personalizeButtonWrapper {
              display: none !important;
            }
          }
        '';

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
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1;
          "browser.uiCustomization.navBarWhenVerticalTabs" = ''
            ["reset-pbm-toolbar-button","back-button","forward-button","vertical-spacer","customizableui-special-spring4","customizableui-special-spring5","customizableui-special-spring6","urlbar-container","customizableui-special-spring9","customizableui-special-spring8","customizableui-special-spring7","downloads-button","unified-extensions-button"]
          '';
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","ublock0_raymondhill_net-browser-action","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","addon_darkreader_org-browser-action"],"nav-bar":["ai-window-toggle","reset-pbm-toolbar-button","back-button","forward-button","vertical-spacer","customizableui-special-spring4","customizableui-special-spring5","customizableui-special-spring6","urlbar-container","customizableui-special-spring9","customizableui-special-spring8","customizableui-special-spring7","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","developer-button","screenshot-button"],"dirtyAreaCache":["unified-extensions-area","nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar"],"currentVersion":25,"newElementCount":10}
          '';

          "layout.css.devPixelsPerPx" = 1.2;
          # "layout.css.prefers-color-scheme.content-override" = 0; # Dark theme # RFP should be disabled for this

          "privacy.resistFingerprinting" = true;
          "privacy.sanitize.sanitizeOnShutdown" = false;

          "identity.fxaccounts.enabled" = true;
          "services.sync.declinedEngines" = "addons,prefs,addresses,creditcards,passwords"; # Sync only bookmarks, open tabs and History

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

            github = {
              name = "GitHub repos search";
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "type";
                      value = "repositories";
                    }
                  ];
                }
              ];

              icon = "https://github.githubassets.com/favicons/favicon.svg";
              definedAliases = ["@gh"];
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
