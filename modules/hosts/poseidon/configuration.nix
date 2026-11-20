{ config, systemAspects, ... }:
{
  configurations.nixos.poseidon = {
    stateVersion = "26.05";

    module = {
      imports = with systemAspects; [
        ./_hardware-configuration.nix
        ## base
        locale
        user
        nh # includes auto clean
        fonts

        wsl
        # hyprland-desktop
      ];

      programs.nix-ld.enable = true;
      wsl.docker-desktop.enable = true;
      wsl.useWindowsDriver = true;
    };
  };
}
