{ homeAspects, ... }: {
  flake.modules.homeManager.alacritty =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ homeAspects.zsh ];

      programs.alacritty = {
        enable = true;
        settings = {
          window = {
            padding = {
              x = 5;
              y = 5;
            };
            dynamic_padding = true;
            opacity = 0.8;
            blur = false;
          };
          font = {
            normal = {
              family = "MesloLGM Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "MesloLGM Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "MesloLGM Nerd Font";
              style = "Italic";
            };
          };
          terminal.shell.program = lib.getExe pkgs.zsh;
        };
        theme = "vscode";
      };
      home.sessionVariables.TERMINAL = "alacritty";
    };
}
