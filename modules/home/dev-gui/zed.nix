{
  flake.modules.homeManager.zed = { pkgs, ... }: {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}
