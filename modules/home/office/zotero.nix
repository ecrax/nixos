{
  flake.modules.homeManager.zotero =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zotero
      ];
    };
}
