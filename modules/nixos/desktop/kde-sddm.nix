{
  flake.modules.nixos.kde-sddm =
    {
      pkgs,
      config,
      ...
    }:
    {
      services = {
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          theme = "where_is_my_sddm_theme";
        };
      };

      environment.systemPackages = [
        (pkgs.where-is-my-sddm-theme.override {
          themeConfig.General = {
            background = "${../../../../wallpapers/login.jpg}";
            backgroundFillMode = "aspect";
            passwordFontSize = "16";
            passwordInputCursorVisible = "false";
            passwordCharacter = "●";
            # passwordInputBackground = "#60ffffff";
            # passwordInputRadius = "10";
          };
        })
      ];
    };
}
