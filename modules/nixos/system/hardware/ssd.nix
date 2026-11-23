{
  flake.modules.nixos.ssd = {
    services.fstrim.enable = true;
    fileSystems."/".options = [
      "noatime"
      "discard"
    ];
  };
}
