{ inputs, ... }:
{
  flake.modules.homeManager.vscode =
    { lib, pkgs, ... }:
    let
      ext = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
    in
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (
          ps: with ps; [ rustup zlib openssl.dev pkg-config ]
        );

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;

          extensions = [
            ext.pmndrs."poimandres-theme"
            ext.github.copilot
            ext.github."copilot-chat"
            ext.esbenp."prettier-vscode"
            ext.charliermarsh.ruff
            ext.myriad-dreamin."tinymist"
            ext.rust-lang."rust-analyzer"
            ext.esbenp."prettier-vscode"
          ];

          userSettings = {
            "workbench.colorTheme" = "poimandres";
            "workbench.startupEditor" = "none";
            "workbench.sideBar.location" = "right";

            "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
            "editor.fontSize" = 16;
            "editor.fontLigatures" = true;
            "editor.wordWrap" = "on";

            "explorer.confirmDragAndDrop" = false;
            "explorer.confirmDelete" = false;
            "git.confirmSync" = false;
            "git.openRepositoryInParentFolders" = "always";

            "tinymist.exportPdf" = "never";
            "tinymist.formatterMode" = "typstyle";

            "[typst]"."editor.defaultFormatter" = "myriad-dreamin.tinymist";
            "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
          }
        };
      };

      home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    };
}
