{
  flake.modules.homeManager."3d-pkgs" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        f3d
      ];
    };
}
