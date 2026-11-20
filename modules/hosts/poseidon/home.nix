{ config, homeAspects, ... }:
{
  configurations.homeManager.poseidon = {
    module =
      { pkgs, ... }:
      {
        imports = with homeAspects; [
          dev-core
          # librewolf
          # hyprland-manager

          ## office
          latex
          typst
        ];

        programs.starship.enable = true;
      };
  };
}
