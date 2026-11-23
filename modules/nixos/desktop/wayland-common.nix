{
  flake.modules.nixos.wayland-common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # pc hardware command line tools
        brightnessctl
        playerctl

        # wayland utils
        wayland-utils # Wayland diagnostic tools
        wl-clipboard # Wayland copy/paste support
      ];
    };
}
