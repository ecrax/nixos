{
  flake.modules.homeManager.librewolf =
    { lib, pkgs, ... }:
    let
      # check about:config, show all, show only modified
      profileSettings = {
        "identity.fxaccounts.enabled" = true;

        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.contentblocking.category" = "strict";

        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "librewolf.webgl.prompt" = true;

        "browser.urlbar.trimURLs" = false;

        "signon.rememberSignons" = true;

        "browser.nova.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.newtabpage.enabled" = false;
        "browser.profiles.enabled" = false;

        "full-screen-api.warning.timeout" = "0"; # this is not applied
        "full-screen-api.transition-duration.enter" = "0";
        "full-screen-api.transition-duration.leave" = "0";
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "sidebar.main.tools" = "history,syncedtabs,bookmarks";

        "browser.download.useDownloadDir" = false;
      };
    in
    {
      programs.librewolf = {
        enable = true;
        configPath = ".config/librewolf/librewolf";

        # Converted from windows: C:\Program Files\LibreWolf\distribution\policies.json
        policies = {
          PictureInPicture = {
            Enabled = false;
            Locked = true;
          };
          AIControls = {
            Translations.Value = "available";
            PDFAltText.Value = "blocked";
            SmartTabGroups.Value = "blocked";
            LinkPreviewKeyPoints.Value = "blocked";
            SidebarChatbot.Value = "blocked";
            SmartWindow.Value = "blocked";
            SpeechRecognition.Value = "blocked";
          };
          AppUpdateURL = "https://localhost";
          ContentAnalysis = {
            Enabled = false;
            InterceptionPoints = {
              Clipboard.Enabled = false;
              ClipboardCopy.Enabled = false;
              Download.Enabled = false;
              DragAndDrop.Enabled = false;
              FileUpload.Enabled = false;
              Print.Enabled = false;
            };
          };
          DisableAppUpdate = true;
          DisableDefaultBrowserAgent = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisableRemoteImprovements = true;
          DisableSetDesktopBackground = false;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          EncryptedMediaExtensions = {
            Enabled = false;
          };
          FirefoxHome = {
            Weather = false;
            TopSites = false;
            SponsoredTopSites = false;
            Highlights = false;
            Stories = false;
            SponsoredStories = false;
          };
          FirefoxSuggest = {
            WebSuggestions = false;
            SponsoredSuggestions = false;
            ImproveSuggest = false;
          };
          UserMessaging = {
            UrlbarInterventions = false;
            SkipOnboarding = true;
            MoreFromMozilla = false;
            FirefoxLabs = false;
          };
          HttpsOnlyMode = "enabled";
          NoDefaultBookmarks = true;
          OverridePostUpdatePage = "";
          OverrideFirstRunPage = "";
          SkipTermsOfUse = true;
          PasswordManagerEnabled = false;
          OfferToSaveLogins = true;
          DisableFormHistory = false;
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
              installation_mode = "normal_installed";
              private_browsing = true;
            };
            # as per https://fleetdm.com/guides/block-firefox-extensions
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "normal_installed";
              private_browsing = true;
            };
          };
          "3rdparty".Extensions = {
            "uBlock0@raymondhill.net".adminSettings = {
              userSettings = rec {
                uiTheme = "dark";
                cloudStorageEnabled = lib.mkForce false;

                importedLists = [
                  "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt"
                  "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
                  "https://raw.githubusercontent.com/Stevoisiak/Stevos-AI-Blocklist/refs/heads/main/GenAI-Blocklist.txt"
                ];

                externalLists = lib.concatStringsSep "\n" importedLists;
              };

              selectedFilterLists = [
                "user-filters"
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-abuse"
                "ublock-unbreak"
                "easylist"
                "easyprivacy"
                "LegitimateURLShortener"
                "urlhaus-1"
                "curben-phishing"
                "plowe-0"

                "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt"
                "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
                "https://raw.githubusercontent.com/Stevoisiak/Stevos-AI-Blocklist/refs/heads/main/GenAI-Blocklist.txt"

                "adguard-generic"
                "adguard-annoyance"
                "adguard-social"
                "adguard-spyware-url"
              ];
            };
          };
          SanitizeOnShutdown = {
            Cache = false;
            Cookies = false;
            History = false;
            FormData = false;
            Sessions = false;
            SiteSettings = false;
            Locked = false;
          };
        };

        profiles.default = {
          id = 0;
          settings = profileSettings;
          userChrome = ''
            #PersonalToolbar{
              --multirow-bmb-n-rows: 3; /* Control how many rows are shown before scrolling */
              --multirow-bmb-row-margin: 2px; /* Control how much spacing is between rows */
              max-height: none !important;
            }
            :root[BookmarksToolbarOverlapsBrowser] :where(#PersonalToolbar){
              height: unset !important;
            }

            #PlacesToolbar > hbox:not(#PlacesToolbarDropIndicatorHolder){
              display: block;
              width: 100vw;
            }

            #PlacesToolbarItems{
              display: flex;
              flex-wrap: wrap;
              /* --uc-bm-padding is defined in autohide_bookmarks_toolbar.css */
              max-height: calc(var(--multirow-bmb-n-rows) * (4px + 1em + (2 * (var(--multirow-bmb-row-margin) + var(--uc-bm-padding,var(--bookmark-block-padding)))))) !important;
              overflow-y:auto;
              scrollbar-color: var(--lwt-accent-color,var(--toolbox-background-color,var(--toolbox-bgcolor))) var(--toolbar-background-color,var(--toolbar-bgcolor));
              scrollbar-gutter: stable;
              scrollbar-width: thin;
            }

            /* Hide the all-bookmarks button */
            #PlacesChevron{ display: none }

            /* Add some spacing between rows, inline margin is collapsed to prevent dragging issues */
            #PlacesToolbarItems > .bookmark-item{
              margin: var(--multirow-bmb-row-margin) 0 !important;
              border-inline: 2px solid transparent;
              visibility: visible !important; /* Just in case they would be hidden for some reason */
            }
          '';
        };
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/http" = "librewolf.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";
        };
      };

    };
}
