{
  flake.modules.homeManager.pkgs-2d =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        aseprite
        gimp
        krita
        nomacs
        inkscape
        darktable
      ];
    };
}
