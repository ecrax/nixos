{
  flake.modules.homeManager.hyprland-manager =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options.hyprland-manager = {
        wallpaper = lib.mkOption {
          type = lib.types.path;
          default = ../../../wallpapers/arcane-1.png;
        };
      };

      config = {

        home.packages = with pkgs; [
          nautilus
          # walker # https://github.com/abenz1267/walker
          hyprlauncher # rofi, wofi
        ];

        home.pointerCursor = {
          enable = true;
          gtk.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 16;
        };

        gtk = {
          enable = true;

          theme = {
            package = pkgs.flat-remix-gtk;
            name = "Flat-Remix-GTK-Grey-Darkest";
          };

          iconTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
          };

          # font = {
          #   name = "MesloLGM Nerd Font";
          #   size = 11;
          # };
        };

        xdg.configFile = { # immutable config for hyprland
          "waybar" = {
            source = ./waybar;
            recursive = true;
            force = true;
          };
          "hypr" = {
            source = ./hypr;
            recursive = true;
            force = true;
          };
        };

        programs.waybar = {
          enable = true;
          systemd.enable = true;
        };

        services = {
          hyprpaper = {
            enable = true;
            settings = {
              preload = [
                (toString config.hyprland-manager.wallpaper)
              ];
              wallpaper = [
                {
                  monitor = "";
                  path = toString config.hyprland-manager.wallpaper;
                }
              ];
              splash = false;
            };
          };
        };

        wayland.windowManager.hyprland = {
          enable = true;
          package = null; # don't install a second version of hyprland
          portalPackage = null; # don't install a second version of hyprland
          systemd.enable = false;
          };
      };
    };
}
