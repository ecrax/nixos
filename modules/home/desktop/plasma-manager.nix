{
  inputs,
  homeAspects,
  ...
}:
{
  flake.modules.homeManager.plasma-manager =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
        homeAspects.foot
      ];

      options.plasma-manager = {
        layouts = lib.mkOption {
          type = lib.types.listOf (
            lib.types.submodule {
              options = {
                layout = lib.mkOption { type = lib.types.str; };
                variant = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };
              };
            }
          );
          default = [
            { layout = "de"; }
          ];
          description = "Keyboard layouts for plasma-manager";
        };

        override = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether plasma-manager should override existing Plasma config on every boot.";
          example = false;
        };

        wallpaper = lib.mkOption {
          type = lib.types.path;
          default = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/DarkestHour/contents/images/2560x1600.jpg";
        };
      };

      config = {
        home.file = {
          ".face.icon" = {
            source = ./.face.icon;
            force = true;
          };
        };

        programs.plasma = {
          enable = true;
          overrideConfig = config.plasma-manager.override;

          session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

          workspace = {
            lookAndFeel = "org.kde.breezedark.desktop";
            wallpaper = config.plasma-manager.wallpaper;
            cursor = {
              theme = "Bibata-Modern-Ice";
              size = 24;
            };
            splashScreen.theme = "None";
          };

          panels = [
            {
              location = "bottom";
              widgets = [
                "org.kde.plasma.kickoff"
                "org.kde.plasma.panelspacer"
                "org.kde.plasma.systemtray"
                "org.kde.plasma.digitalclock"
              ];
              hiding = "autohide";
            }
          ];

          kwin = {
            edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
            cornerBarrier = false;
          };

          kscreenlocker = {
            lockOnResume = true;
            timeout = 0;
            appearance.wallpaper = config.plasma-manager.wallpaper;
          };

          krunner = {
            activateWhenTypingOnDesktop = true;
            historyBehavior = "enableSuggestions";
            position = "center";
            shortcuts.launch = "Alt+Space";
          };

          powerdevil = {
            AC = {
              powerButtonAction = "lockScreen";
              autoSuspend = {
                action = "nothing";
              };
              turnOffDisplay = {
                idleTimeout = 1000;
                idleTimeoutWhenLocked = "immediately";
              };
            };
            battery = {
              powerButtonAction = "lockScreen";
              whenSleepingEnter = "standbyThenHibernate";
            };
            lowBattery = {
              whenLaptopLidClosed = "hibernate";
            };
          };

          shortcuts = {
            ksmserver = {
              "Lock Session" = [
                "Screensaver"
                "Meta+Ctrl+Alt+L"
              ];
            };

            kwin = {
              "Expose" = "Meta+Tab";
              "Window Maximize" = "Meta+F";
              "Window Fullscreen" = "Meta+Shift+F";
              "Window Minimize" = "Meta+M";
              "Switch Window Down" = "Meta+J";
              "Switch Window Left" = "Meta+H";
              "Switch Window Right" = "Meta+L";
              "Switch Window Up" = "Meta+K";
              "Switch to Desktop 1" = "Meta+1";
              "Switch to Desktop 2" = "Meta+2";
              "Switch to Desktop 3" = "Meta+3";
              "Switch to Desktop 4" = "Meta+4";
              "Switch to Desktop 5" = "Meta+5";
              "Switch to Desktop 6" = "Meta+6";
              "Switch to Desktop 7" = "Meta+7";
              "Switch to Desktop 8" = "Meta+8";
              "Switch to Desktop 9" = "Meta+9";
              "Toggle Overview" = "Alt+Tab";
              "Toggle Tiles Editor" = "Meta+Alt+T";
              "Window Close" = [
                "Meta+C"
                "Alt+F4"
              ];
              # layout dependent:
              "Window to Desktop 1" = "Meta+!"; # Meta+Shift+1
              "Window to Desktop 2" = "Meta+\""; # Meta+Shift+2
              "Window to Desktop 3" = "Meta+§"; # Meta+Shift+3
              "Window to Desktop 4" = "Meta+$"; # Meta+Shift+4
              "Window to Desktop 5" = "Meta+%"; # Meta+Shift+5
              "Window to Desktop 6" = "Meta+&"; # Meta+Shift+6
              "Window to Desktop 7" = "Meta+/"; # Meta+Shift+7
              "Window to Desktop 8" = "Meta+("; # Meta+Shift+8
              "Window to Desktop 9" = "Meta+)"; # Meta+Shift+9
            };
          };

          hotkeys.commands = {
            "launch-terminal" = {
              name = "Launch Terminal";
              key = "Meta+T";
              command = "foot";
            };
          };

          spectacle.shortcuts.launch = "Meta+Shift+S";

          input = {
            keyboard = {
              numlockOnStartup = "on";
              layouts = config.plasma-manager.layouts;
            };
            mice = [
              # logitech mouse (TODO: this is currently not applied)
              {
                enable = true;
                name = "Logitech USB Receiver";
                vendorId = "046d";
                productId = "c54d";
                accelerationProfile = "none";
                acceleration = 0;
                scrollSpeed = 1;
                naturalScroll = false;
              }
            ];
            touchpads = [
              {
                # acer touchpad config cf. https://nix-community.github.io/plasma-manager/options.html#opt-programs.plasma.input.touchpads._.productId
                enable = true;
                disableWhileTyping = false;
                leftHanded = false;
                middleButtonEmulation = false;
                name = "ELAN0515:00 04F3:3142 Touchpad";
                naturalScroll = false;
                pointerSpeed = 0;
                accelerationProfile = "default";
                productId = "3142";
                tapToClick = true;
                vendorId = "04f3";
                scrollSpeed = 5;
              }
            ];
          };

          configFile = {
            baloofilerc."Basic Settings"."Indexing-Enabled" = false;
            kwinrc = {
              "org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
              Desktops.Number = {
                value = 9;
              };
            };
            breezerc.Common.ShadowSize = "ShadowNone";
            kdeglobals = {
              General = {
                TerminalApplication = "foot";
                TerminalService = "Foot.desktop";
              };
              KDE = {
                AnimationDurationFactor = 0;
              };
            };
          };
        };
      };
    };
}
