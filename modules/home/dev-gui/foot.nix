{ homeAspects, ... }: {
  flake.modules.homeManager.foot =
    {
      pkgs,
      lib,
      ...
    }:
    let
      nvim-dark = {
        alpha = "0.8";
        cursor = "14161b e0e2ea"; # NvimDarkGrey2 NvimLightGrey2
        foreground = "e0e2ea"; # NvimLightGrey2
        background = "14161b"; # NvimDarkGrey2

        selection-foreground = "e0e2ea"; # NvimLightGrey2
        selection-background = "4f5258"; # NvimDarkGrey4

        regular0 = "07080d"; # NvimDarkGrey1
        regular1 = "ffc0b9"; # NvimLightRed
        regular2 = "b3f6c0"; # NvimLightGreen
        regular3 = "fce094"; # NvimLightYellow
        regular4 = "a6dbff"; # NvimLightBlue
        regular5 = "ffcaff"; # NvimLightMagenta
        regular6 = "8cf8f7"; # NvimLightCyan
        regular7 = "c4c6cd"; # NvimLightGrey3

        bright0 = "2c2e33"; # NvimDarkGrey3
        bright1 = "ffc0b9"; # NvimLightRed
        bright2 = "b3f6c0"; # NvimLightGreen
        bright3 = "fce094"; # NvimLightYellow
        bright4 = "a6dbff"; # NvimLightBlue
        bright5 = "ffcaff"; # NvimLightMagenta
        bright6 = "8cf8f7"; # NvimLightCyan
        bright7 = "eef1f8"; # NvimLightGrey1
      };
    in
    {
      imports = [ homeAspects.zsh ];

      programs.foot = {
        enable = true;
        settings = {
          main = {
            dpi-aware = "yes";
            font = "MesloLGM Nerd Font:size=10";
            shell = lib.getExe pkgs.zsh;
            initial-color-theme = "dark";
            pad = "0x0"; # "10x10"
          };
          mouse = {
            hide-when-typing = "yes";
          };
          bell = {
            system = "no";
            urgent = "no";
            notify = "no";
            visual = "no";
          };
          scrollback = {
            lines = 10000;
          };
          colors-dark = nvim-dark;
        };
      };
      home.sessionVariables.TERMINAL = lib.mkForce "foot";
    };
}
