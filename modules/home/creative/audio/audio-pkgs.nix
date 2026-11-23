{
  flake.modules.homeManager.audio-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        audacity
        ardour
      ];
    };
}
