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
    # Customize keyboards shortcuts
    # I don't know why it's not in firefox home-manager
    home.file.".librewolf/repinek/customKeys.json" = {
      force = true;
      text = builtins.toJSON {
        key_search = {};
        key_search2 = {};
        printKb = {};
        key_savePage = {};
        key_closeWindow = {};
        openFileKb = {};
        key_privatebrowsing = {};
        key_newNavigator = {};
        focusURLBar2 = {};
        key_switchTextDirection = {};
        key_findAgain2 = {};
        key_findPrevious2 = {};
        key_gotoHistory = {};
        viewBookmarksSidebarKb = {};
        viewGenaiChatSidebarKb = {};
        viewOpenTabsSidebarKb = {};
        toggleSidebarKb = {};
        key_toggleReaderMode = {};
        key_togglePictureInPicture = {};
        viewBookmarksToolbarKb = {};
        key_sanitize = {};
        bookmarkAllTabsKb = {};
        key_openAddons = {};
        key_viewInfo = {};
        key_screenshot = {};
      };
    };

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

        # Some elements taken from https://git.symlinx.net/daccfiles/tree/.config/browser_stuff/
        # and https://github.com/mbnuqw/sidebery#how-to-hide-native-tabs
        userChrome = ''
          /* Themed (pywalfox) right-click menu */
          .menupopup-arrowscrollbox {
            background: var(--lwt-accent-color) !important;
            color: var(--lwt-text-color) !important;
          }

          menupopup menu,
          menupopup menuitem {
            color: var(--lwt-text-color) !important;
          }

          menupopup menu[_moz-menuactive="true"]:not([disabled="true"]),
          menupopup menuitem[_moz-menuactive="true"]:not([disabled="true"]) {
            background: color-mix(
              in srgb,
              var(--lwt-accent-color) 82%,
              var(--lwt-text-color)
            ) !important;
          }

          /* Sidebery (messy) */
          /* Hide sidebar-panel-header (sidebar.revamp: true) */
          #sidebar-panel-header {
            display: none !important;
          }

          #main-window {
            /* Hide horizontal native tabs toolbar */
            #TabsToolbar >* {
              display: none !important;
            }

            /* Hide new Firefox sidebar, restyle addon's sidebar */
            #sidebar-main, #sidebar-container, #sidebar-launcher-splitter {
              display: none !important;
            }
            #sidebar-box {
              padding: 0 !important;
              border-radius: 0 !important;
              border: none !important;
            }
            #sidebar-box #sidebar {
              box-shadow: none !important;
              border: none !important;
              outline: none !important;
              border-radius: 0 !important;
            }
            #sidebar-splitter {
              --splitter-width: 3px !important;
              min-width: var(--splitter-width) !important;
              width: var(--splitter-width) !important;
              padding: 0 !important;
              margin: 0 calc(-1*var(--splitter-width) + 1px) 0 0 !important;
              border: 0 !important;
              opacity: 0 !important;
            }
          }

          /* Global corner radius (Maybe some day I will put 0px here) */
          * { border-radius: 4px !important; }

          /* Hide close firefox button (not tab) */
          .titlebar-buttonbox-container {
              display: none !important;
          }
        '';

        userContent = ''
          @-moz-document url-prefix("about:") {
            * {
              border-radius: 4px !important;
            }

            /* Hide settings button */
            .personalizeButtonWrapper {
              display: none !important;
            }
          }
        '';

        extensions.packages = with inputs.firefox-addons.packages.x86_64-linux; [
          vimium
          ublock-origin
          darkreader
          proton-pass
          refined-github
          # You can't use pywalfox css because it's readonly
          # But what you can do instead, since we are using noctalia + pywalfox-beta4
          # pywalfoxUserChrome = builtins.readFile "${inputs.noctalia.outPath}/assets/firefox_theme/css/userChrome.css";
          # but tbh, this css is gore, so I prefer to not use it
          pywalfox
          clearurls
          sidebery

          # TODO:
          # oii (osu improvement indicator)
          # yomitan and asbplayer not sure if I needed it tho

          # I had foxyproxy before, but I don't use proxy anymore
          # Because I have vpn 24/7
          # Also I don't need any youtube extensions for now
          # Since I'm not watching youtube on pc
        ];

        /*
        I don't like configure extensions declarative
        If not present = default

            Vimium
        IgnoreKeyboardLayout = true
        NewTabDestination = browserNewTabPage

            Ublock Origin
        Enable cloud storage support = true
        Custom accent Color = true
        Block remote fonts = true
        Disable JavaScript = true

            Pywalfox
        Fetch colors on startup = true
        Use DuckDuckGo theme? = true

            Dark Reader
        Enable by default = false
        Detect dark theme = false

            Sidebery
        todo, a lot of settings
        Custom CSS:
        #root.root {--toolbar-bg: var(--lwt-accent-color);}
        #root.root {--general-border-radius: 4px;}
        */

        # Bookmarks synced using firefox account

        # TODO: containers with sidebery

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
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c078156-979c-498b-8990-85f7987dd929_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","ublock0_raymondhill_net-browser-action","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","addon_darkreader_org-browser-action","_e844d8ad-7f10-4de7-ad36-13c95d10aae4_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"nav-bar":["ai-window-toggle","reset-pbm-toolbar-button","back-button","forward-button","vertical-spacer","customizableui-special-spring4","customizableui-special-spring5","customizableui-special-spring6","urlbar-container","customizableui-special-spring9","customizableui-special-spring8","customizableui-special-spring7","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","pywalfox_frewacom_org-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","developer-button","screenshot-button","_e844d8ad-7f10-4de7-ad36-13c95d10aae4_-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"dirtyAreaCache":["unified-extensions-area","nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar"],"currentVersion":26,"newElementCount":11}
          '';
          "browser.translations.automaticallyPopup" = false;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.searches" = true;

          "findbar.highlightAll" = true; # Highlight all Ctrl+F

          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # Never used it

          "layout.css.devPixelsPerPx" = 1.2;
          # "layout.css.prefers-color-scheme.content-override" = 0; # Dark theme # RFP should be disabled for this

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.letterboxing" = true;
          "privacy.sanitize.sanitizeOnShutdown" = false;

          "identity.fxaccounts.enabled" = true;
          "services.sync.declinedEngines" = "addons,prefs,addresses,creditcards,passwords"; # Sync only bookmarks, open tabs and History

          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable userChrome.css and userContent.css
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
                  template = "https://www.youtube.com/results";
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

            # I wanna add this, but it's not working because youtube
            # youtubeHistory = {
            #   name = "Youtube History";
            #   urls = [
            #     {
            #       template = "https://www.youtube.com/feed/history";
            #       params = [
            #         {
            #           name = "query";
            #           value = "{searchTerms}";
            #         }
            #       ];
            #     }
            #   ];

            #   icon = "https://www.google.com/s2/favicons?domain=youtube.com";
            #   definedAliases = ["@yth"];
            # };

            # Hide mojeek and startpage
            mojeek.metaData.hidden = true;
            startpage.metaData.hidden = true;
          };
        };
      };
    };
  };
}
