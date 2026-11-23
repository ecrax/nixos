{ inputs, ... }:
{
  flake.modules.homeManager.spotatui = { pkgs, ... }: {
    home.packages = [
      inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
