{
  flake.modules.nixos.kde-gdm = {
    services = {
      displayManager.gdm.enable = true;
      displayManager.defaultSession = "plasma";
    };
  };
}
