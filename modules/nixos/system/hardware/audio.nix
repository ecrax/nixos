{
  flake.modules.nixos.audio = { pkgs, ... }: {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      # jack.enable = true;
    };
    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      alsa-utils
      pavucontrol
      pamixer
      # pipewire.jack
    ];
  };
}
