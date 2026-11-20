{ config, homeAspects, ... }: {
  flake.modules.homeManager.vscodium = { pkgs, ... }: {
    imports = [ homeAspects.zsh ];

    programs.vscodium = {
      enable = true;
      package = pkgs.vscodium.fhsWithPackages (
        ps: with ps; [
          rustup
          zlib
          openssl.dev
          pkg-config
        ]
      );
      # profiles.default = {
      #   extensions = with pkgs.vscode-extensions; [
      #     usernamehw.errorlens
      #     charliermarsh.ruff
      #     eamodio.gitlens
      #     esbenp.prettier-vscode
      #     myriad-dreamin.tinymist
      #     rust-lang.rust-analyzer
      #     tamasfe.even-better-toml
      #   ];
      #   userSettings = {
      #     "workbench.sideBar.location" = "right";
      #     "editor.mouseWheelZoom" = true;
      #     "editor.formatOnSave" = true;
      #     "gitlens.ai.enabled" = false;
      #     "editor.renderWhitespace" = "all";
      #     "explorer.compactFolders" = false;
      #     "git.confirmSync" = false;
      #     "redhat.telemetry.enabled" = false;
      #     "explorer.confirmDragAndDrop" = false;
      #     "explorer.confirmDelete" = false;
      #     "git.enableSmartCommit" = true;
      #   };
      # };
    };

    programs.zsh.shellAliases = {
      code = "codium";
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
