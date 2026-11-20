{
  flake.modules.homeManager.games-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        godot
        steam-run # used to run an exported godot project
      ];
    };
}
