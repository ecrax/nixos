{
  flake.modules.nixos.locale =
    {
      config,
      lib,
      ...
    }:
    let
      extraLocale = "de_DE.UTF-8";
    in
    {
      time.timeZone = lib.mkDefault "Europe/Berlin";

      i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        extraLocaleSettings = lib.mapAttrs (_: lib.mkDefault) {
          LC_ADDRESS = extraLocale;
          LC_IDENTIFICATION = extraLocale;
          LC_MEASUREMENT = extraLocale;
          LC_MONETARY = extraLocale;
          LC_NAME = extraLocale;
          LC_NUMERIC = extraLocale;
          LC_PAPER = extraLocale;
          LC_TELEPHONE = extraLocale;
          LC_TIME = extraLocale;
        };
      };

      services.xserver.xkb.layout = lib.mkDefault "de";
      console.keyMap = lib.mkDefault config.services.xserver.xkb.layout;
    };
}
