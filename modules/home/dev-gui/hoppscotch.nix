{
  flake.modules.homeManager.hoppscotch = { pkgs, ... }: {
    home.packages = with pkgs; [
      hoppscotch
    ];
  };
}
