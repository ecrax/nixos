{
  flake.modules.homeManager.pkgs-dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ripgrep
        p7zip
        unzip
        unrar
        wget
        inetutils
        btop
        fzf
        fd
        comma
        usbutils
        tldr
        vim
      ];
    };
}
