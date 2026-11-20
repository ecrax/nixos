{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      services.xserver.enable = true;
      services.displayManager.gdm.enable = true;
      services.displayManager.defaultSession = "hyprland-uwsm";

      programs = {
        hyprland = {
          enable = true;
          xwayland.enable = true;
          withUWSM = true;
        };
      };

      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.gdm-password.enableGnomeKeyring = true;
      services.gvfs.enable = true; # this is for nautilus
      services.power-profiles-daemon.enable = true;

      environment.systemPackages = with pkgs; [
        seahorse
        nwg-look
        hyprshot
        wl-clip-persist
      ];

    };
}
