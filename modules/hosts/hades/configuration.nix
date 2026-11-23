{ systemAspects, ... }:
{
  configurations.nixos.hades = {
    stateVersion = "26.05";

    module = { pkgs, ... }: {
      # TODO: remove this once zotero updates
      nixpkgs.config.permittedInsecurePackages = [
        "firefox-esr-140-bin-unwrapped-140.17.0esr"
      ];

      imports = with systemAspects; [
        ./_hardware-configuration.nix
        base

        nvidia
        docker
        vm
        nix-registry
        musnix

        plasma-desktop
      ];

      environment.systemPackages = with pkgs; [
      ];
    };
  };
}
