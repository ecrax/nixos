{
  flake.modules.nixos.kde-plasma =
    {
      pkgs,
      ...
    }:
    {
      services = {
        desktopManager.plasma6.enable = true;
        # xserver.enable = true;
        keyd = {
          enable = true;
          keyboards = {
            # The name is just the name of the configuration file, it does not really matter
            default = {
              ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
              # Everything but the ID section:
              settings = {
                # The main layer, if you choose to declare it in Nix
                main = {
                  capslock = "esc"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
                };
                otherlayer = { };
              };
            };
          };
        };
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

        # misc
        kdePackages.plasma-workspace-wallpapers # default wallpapers
      ];

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        aurorae # remove for themes other than default breeze
        plasma-browser-integration
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
