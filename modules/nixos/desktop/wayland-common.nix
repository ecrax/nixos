{
  flake.modules.nixos.wayland-common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
        playerctl
        wayland-utils # Wayland diagnostic tools
        wl-clipboard # Wayland copy/paste support
      ];
    };
}
