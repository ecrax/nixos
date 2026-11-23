{
  flake.modules.homeManager.pkgs-3d =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        f3d
      ];
    };
}
