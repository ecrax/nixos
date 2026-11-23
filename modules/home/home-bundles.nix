{ homeAspects, ... }: {
  flake.modules.homeManager = with homeAspects; {
    communication.imports = [
      discord
      thunderbird
    ];

    creative-2d.imports = [
      "2d-pkgs"
    ];

    creative-3d.imports = [
      "3d-pkgs"
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
      dev-pkgs
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
