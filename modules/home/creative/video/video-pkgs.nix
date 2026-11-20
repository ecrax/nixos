{
  flake.modules.homeManager.video-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        handbrake
      ];
    };
}
