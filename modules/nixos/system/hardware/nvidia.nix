# Nvidia configuration for NixOS with Wayland support
# Import this module only if you have an Nvidia GPU
# adapted from nixy: https://github.com/anotherhadi/nixy/blob/main/modules/system/hardware/nvidia.nix
{
  flake.modules.nixos.nvidia =
    {
      pkgs,
      config,
      ...
    }:
    let
      nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.production;
    in
    {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware = {
        nvidia = {
          open = true;
          nvidiaSettings = false;
          powerManagement.enable = true;
          # dynamicBoost.enable = true; # only relevant for laptops
          modesetting.enable = true;
          package = nvidiaDriverChannel;
        };

        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = [ pkgs.nvidia-vaapi-driver ];
        };
      };

      environment.systemPackages = with pkgs; [
        vulkan-tools
        mesa-demos
        libva-utils
      ];
    };
}
