{
  flake.modules.homeManager.dev-pkgs =
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
