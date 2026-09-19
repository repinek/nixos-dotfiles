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
          /* Themed (pywalfox) right-click menu */
          .menupopup-arrowscrollbox {
            background: var(--lwt-accent-color) !important;
            color: var(--lwt-text-color) !important;
          }

          menupopup menu,
          menupopup menuitem {
            color: var(--lwt-text-color) !important;
            border-radius: 4px !important;
          }

          menupopup menu[_moz-menuactive="true"]:not([disabled="true"]),
          menupopup menuitem[_moz-menuactive="true"]:not([disabled="true"]) {
            background: color-mix(
              in srgb,
              var(--lwt-accent-color) 82%,
              var(--lwt-text-color)
            ) !important;
          }

          /* Url Bar */
          #urlbar,
          #searchbar,
          #searchbar-new {
            --urlbar-inner-border-radius: 4px !important;
          }

          #urlbar-background,
          .urlbar-background,
          .urlbar-input-container,
          #searchbar {
            border-radius: 4px !important;
          }

          /* Tabs */
          #tabbrowser-tabs[orient="vertical"] .tabbrowser-tab .tab-background,
          #tabbrowser-tabs[orient="vertical"] .tabbrowser-tab[pinned] .tab-content {
            border-radius: 4px !important;
          }

          /* Vertical tab group */
          #tabbrowser-tabs[orient="vertical"] .tab-group-label {
            border-radius: 4px !important;
          }

          /* Bookmarks */
          #PlacesToolbarItems > toolbarbutton.bookmark-item,
          #PersonalToolbar toolbarbutton.bookmark-item,
          #PlacesToolbar menupopup[placespopup],
          #PlacesToolbar menupopup[placespopup]::part(content),
          #PlacesToolbar menupopup[placespopup] menu,
          #PlacesToolbar menupopup[placespopup] menuitem,
          #PlacesToolbar menupopup[placespopup] .bookmark-item,
          #PlacesToolbar menupopup[placespopup] .openintabs-menuitem {
            border-radius: 4px !important;
          }

          /* Hide bottom separator on sidebar */
          #sidebar-main .buttons-wrapper,
          #sidebar-tools-and-extensions-splitter {
            display: none !important;
          }
        '';

        userContent = ''
          @-moz-document url("about:newtab"), url("about:home") {
            /* Search bar */
            .search-handoff-button,
            #newtab-search-text {
              border-radius: 4px !important;
            }

            /* Hide settings button */
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
          # You can't use pywalfox css, because it's readonly
          # But what you can do instead, since we are using noctalia + pywalfox-beta4
          # pywalfoxUserChrome = builtins.readFile "${inputs.noctalia.outPath}/assets/firefox_theme/css/userChrome.css";
          # but tbh, this css is gore, so I prefer to not use it
          pywalfox
          clearurls

          # TODO:
          # oii (osu improvement indicator)
          # yomitan
          # asbplayer not sure if I needed it tho

          # I had foxyproxy before, but I don't use proxy anymore
          # Because I have vpn 24/7
          # Also I don't need any youtube extensions for now
          # Since I'm not watching youtube on pc
        ];

        # TODO: add bookmarks UPD: not sure if I need it

        settings = {
          "intl.locale.requested" = "uk-UA,en-GB"; # Use fallback (second) language if localization is incomplete on first

          "extensions.autoDisableScopes" = 0; # Automatically enable extensions (from example)

          "browser.startup.page" = 3; # Open previous windows and tabs
          "browser.sessionstore.newTabOnRestore" = true; # Also open a new tab
          "browser.settings-redesign.promo.dismissed" = true;
          "browser.toolbars.bookmarks.visibility" = "newtab"; 
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1;
          "browser.uiCustomization.navBarWhenVerticalTabs" = ''
            ["reset-pbm-toolbar-button","back-button","forward-button","vertical-spacer","customizableui-special-spring4","customizableui-special-spring5","customizableui-special-spring6","urlbar-container","customizableui-special-spring9","customizableui-special-spring8","customizableui-special-spring7","downloads-button","unified-extensions-button"]
          '';
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","ublock0_raymondhill_net-browser-action","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","addon_darkreader_org-browser-action"],"nav-bar":["ai-window-toggle","reset-pbm-toolbar-button","back-button","forward-button","vertical-spacer","customizableui-special-spring4","customizableui-special-spring5","customizableui-special-spring6","urlbar-container","customizableui-special-spring9","customizableui-special-spring8","customizableui-special-spring7","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","developer-button","screenshot-button"],"dirtyAreaCache":["unified-extensions-area","nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar"],"currentVersion":25,"newElementCount":10}
          '';
          "browser.translations.automaticallyPopup" = false;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.searches" = true;

          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # Never used it

          "layout.css.devPixelsPerPx" = 1.2;
          # "layout.css.prefers-color-scheme.content-override" = 0; # Dark theme # RFP should be disabled for this

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.letterboxing" = true;
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
              definedAliases = ["@hm"];
            };

            github = {
              name = "GitHub repos";
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
              definedAliases = ["@gh" "@git"];
            };

            youtube = {
              name = "Youtube";
              urls = [
                {
                  template = "https://youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "https://www.google.com/s2/favicons?domain=youtube.com";
              definedAliases = ["@yt"];
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
