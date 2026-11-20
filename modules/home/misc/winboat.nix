{
  flake.modules.homeManager.winboat = { pkgs, ... }: {
    home.packages = with pkgs; [
      winboat
    ];
  };
}
