{ homeAspects, ... }:
{
  configurations.homeManager.hades = {
    module =
      { pkgs, ... }:
      {
        imports = with homeAspects; [
          communication
          # creative-2d
          # creative-3d
          # creative-audio
          # creative-games
          # creative-video
          dev-core
          dev-gui
          office
          plasma-manager

          solaar
          spotatui
        ];

        home.packages = with pkgs; [
        ];

        programs.starship.enable = true;
      };
  };
}
