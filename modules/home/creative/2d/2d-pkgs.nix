{
  flake.modules.homeManager."2d-pkgs" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        aseprite
        gimp
        krita
      ];
    };
}
