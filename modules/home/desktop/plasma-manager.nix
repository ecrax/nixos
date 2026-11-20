{
  inputs,
  ...
}:
{
  flake.modules.homeManager.plasma-manager = { lib, config, ... }: {
    imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

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
        default = true;
        description = "Whether plasma-manager should override existing Plasma config on every boot.";
        example = false;
      };

      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../../wallpapers/arcane-1.png;
      };
    };

    config = {
      programs.plasma = {
        enable = true;
        overrideConfig = config.plasma-manager.override;

        session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

        workspace = {
          lookAndFeel = "org.kde.breezedark.desktop";
          wallpaper = config.plasma-manager.wallpaper;
          cursor = {
            theme = "Bibata-Modern-Ice";
            size = 20;
          };
        };

        panels = [
          {
            location = "bottom";
            widgets = [
              "org.kde.plasma.kickoff"
              "org.kde.plasma.icontasks"
              "org.kde.plasma.marginsseparator"
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
            # "Switch Window to Desktop 1" = "Meta+Shift+1";
            # "Switch Window to Desktop 2" = "Meta+Shift+2";
            # "Switch Window to Desktop 3" = "Meta+Shift+3";
            # "Switch Window to Desktop 4" = "Meta+Shift+4";
            # "Switch Window to Desktop 5" = "Meta+Shift+5";
            # "Switch Window to Desktop 6" = "Meta+Shift+6";
            # "Switch Window to Desktop 7" = "Meta+Shift+7";
            # "Switch Window to Desktop 8" = "Meta+Shift+8";
            # "Switch Window to Desktop 9" = "Meta+Shift+9";
            "Toggle Overview" = "Alt+Tab";
          };
        };

        hotkeys.commands = {
          "launch-terminal" = {
            name = "Launch Terminal";
            key = "Meta+T";
            command = "alacritty";
          };
        };

        input = {
          keyboard = {
            numlockOnStartup = "on";
            layouts = config.plasma-manager.layouts;
          };
          mice = [ ];
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
              TerminalApplication = "alacritty";
              TerminalService = "Alacritty.desktop";
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
