{ inputs, ... }: {
  flake.modules.homeManager.zen =
    { lib, ... }:
    let
      profileSettings = {
        "webgl.disabled" = false;
        "browser.download.useDownloadDir" = false;
      };
    in
    {
      imports = [ inputs.zen-browser.homeModules.twilight ]; # beta, twilight or twilight-official

      xdg.mimeApps.enable = true;

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        policies = {
          PictureInPicture = {
            Enabled = false;
            Locked = true;
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
          PasswordManagerEnabled = false;
          OfferToSaveLogins = true;
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
              installation_mode = "normal_installed";
              private_browsing = true;
            };
            "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
              installation_mode = "normal_installed";
              private_browsing = true;
            };
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "normal_installed";
              private_browsing = true;
            };
            "wappalyzer@crunchlabz.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi";
              installation_mode = "normal_installed";
            };
            "zotero@chnm.gmu.edu" = {
              install_url = "https://www.zotero.org/download/connector/dl?browser=firefox";
              installation_mode = "normal_installed";
            };
          };
          "3rdparty".Extensions = {
            "uBlock0@raymondhill.net".adminSettings = {
              userSettings = rec {
                uiTheme = "dark";
                cloudStorageEnabled = lib.mkForce false;
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
      };
    };
}
