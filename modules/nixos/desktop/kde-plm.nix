{
  flake.modules.nixos.kde-plm = { pkgs, ... }: {
    services = {
      displayManager = {
        plasma-login-manager.enable = true;
        defaultSession = "plasma";
      };
    };

    environment.etc = {
      "plasmalogin.conf" = {
        text = ''
          [Greeter][Wallpaper][org.kde.image][General]
          Image=file://${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/DarkestHour/contents/images/2560x1600.jpg
        '';
        mode = "0444"; # 0644 originally
      };
    };
  };
}
