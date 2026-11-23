{ systemAspects, ... }: {
  flake.modules.nixos = with systemAspects; {
    base.imports = [
      boot # includes plymouth
      locale
      user
      audio
      printing
      bluetooth
      network
      nh # includes auto clean
      fonts
      power-manager
      ssd
      default-libraries
    ];

    plasma-desktop.imports = [
      kde-plm
      kde-plasma
      wayland-common
    ];
  };
}
