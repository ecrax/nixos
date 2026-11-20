{
  flake.modules.nixos.kde =
    { pkgs, ... }:
    {
      services = {
        desktopManager.plasma6.enable = true;
        # xserver.enable = true;
      };

      programs.kde-pim.enable = false;

      # list of all packages: https://github.com/NixOS/nixpkgs/blob/nixos-26.05/nixos/modules/services/desktop-managers/plasma6.nix
      environment.systemPackages = with pkgs; [
        # KDE Utilities
        kdePackages.kcalc # Calculator
        kdePackages.kcharselect # Character map
        kdePackages.kclock # Clock app
        kdePackages.kcolorchooser # Color picker
        kdePackages.kolourpaint # Simple paint program
        kdePackages.ksystemlog # System log viewer
        kdiff3 # File/directory comparison tool
        kdePackages.elisa # Music player

        # Hardware/System Utilities (Optional)
        kdePackages.isoimagewriter # Write hybrid ISOs to USB
        kdePackages.filelight # Disk space usage viewer
        kdePackages.partitionmanager # Disk and partition management
        kdePackages.kamoso # Camera app
        hardinfo2 # System benchmarks and hardware info
      ];

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        aurorae # remove for themes other than default breeze
        plasma-browser-integration
        plasma-workspace-wallpapers
        konsole
        ark
        okular
        kate
        ktexteditor
        khelpcenter
        dolphin-plugins
        krdp
        plasma-keyboard
        qtvirtualkeyboard
        discover
        qrca
      ];
    };
}
