{ homeAspects, ... }: {
  flake.modules.homeManager = with homeAspects; {
    communication.imports = [
      discord
      thunderbird
    ];

    creative-2d.imports = [
      pkgs-2d
    ];

    creative-3d.imports = [
      pkgs-3d
      blender
    ];

    creative-audio.imports = [
      audio-pkgs
    ];

    creative-games.imports = [
      games-pkgs
    ];

    creative-video.imports = [
      ffmpeg
      obs
      video-pkgs
    ];

    dev-core.imports = [
      bun
      pkgs-dev
      direnv
      git
      helix
      lazyvim
      tmux
      yazi
      zsh
    ];

    dev-gui.imports = [
      alacritty
      foot
      hoppscotch
      vscodium
    ];

    office.imports = [
      latex
      libreoffice
      librewolf
      typst
      zotero
    ];
  };
}
