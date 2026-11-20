{
  flake.modules.homeManager.dev-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        uv
        go
        nil
        nixd
        nixfmt
        ripgrep
        python3
        jdk
        maven
        gnumake
        gcc
        p7zip
        unzip
        unrar
        wget
        inetutils
        btop
        vim
      ];
    };
}
