{ inputs, ... }: {
  flake.modules.homeManager.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true; # adds a wrapper that cd's your shell on quit
        shellWrapperName = "y";      # set explicitly, the default has changed between releases

        plugins.audio-preview = {
          package = inputs.audio-preview-yazi;
          setup = true; # generates require("audio-preview"):setup() in init.lua
          # settings = { tool = "auto"; bitrate = true; }; # optional, defaults shown in the README
        };

        settings = {
          mgr = {
            show_hidden = true;
            sort_by = "natural";
            linemode = "audio"; # shows duration, channels, sample rate and size
          };
          plugin = {
            prepend_previewers = [
              { mime = "audio/*"; run = "audio-preview"; }
            ];
            prepend_preloaders = [
              { mime = "audio/*"; run = "audio-preview"; }
            ];
            prepend_fetchers = [
              { mime = "audio/*"; run = "audio-preview"; group = "audio"; }
            ];
          };
        };
      };

      # optional helpers yazi uses for previews, search and jumping
      home.packages = with pkgs; [
        sox
        ffmpeg
        jq
        poppler-utils
        fd
        ripgrep
        fzf
        zoxide
        imagemagick
      ];
    };
}
