{ config, homeAspects, ... }: {
  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    {
      imports = [ homeAspects.git ];

      home.packages = with pkgs; [
        pfetch-rs
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          gs = "git status";
          ga = "git add .";
          gc = "git commit -a -m";
          gps = "git push";
          gpl = "git pull";
          gst = "git stash";
          gsp = "git stash; git pull";
          gcheck = "git checkout";
          gcredential = "git config credential.helper store";
          gg = "lazygit";
          ":q" = "exit";
          l = "ls -la";
          ".." = "cd ..";
        };

        initContent = ''
          pfetch
        '';
      };
    };
}
