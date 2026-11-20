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
    ];

    plasma-desktop.imports = [
      kde
      # kde-sddm
      kde-gdm
      wayland-common
    ];

    hyprland-desktop.imports = [
      hyprland
      wayland-common
    ];
  };
}
