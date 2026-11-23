{
  flake.modules.nixos.default-libraries =
    {
      pkgs,
      ...
    }:
    {
      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc.lib
        imagemagick
        libx11
        libxext
        libxrandr
        libxi
        libxcursor
        libxcomposite
        libxdamage
        libxfixes
        libxrender
        libxtst
        libxcb
        libxkbcommon
        libGL
        libglvnd
        mesa
        wayland
        fontconfig
        freetype
        glib
        dbus
        nss
        nspr
        alsa-lib
        cups
        expat
        libdrm
        libpng
        libxkbfile

        # default as per: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/nix-ld.nix
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
      ];
    };
}
