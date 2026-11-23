{ inputs, ... }:
{
  flake.modules.homeManager.vscode =
    { lib, pkgs, ... }:
    let
      ext = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;

      prettier = "esbenp.prettier-vscode";
      prettierLangs = [
        "typescript" "typescriptreact" "javascript" "javascriptreact"
        "json" "jsonc" "css" "scss" "markdown" "mdx"
      ];
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

          extensions = with ext; [
            pmndrs.poimandres-theme # verify the id in the Extensions view
            github.copilot
            github.copilot-chat
            esbenp.prettier-vscode
            charliermarsh.ruff
            myriad-dreamin.tinymist
            rust-lang.rust-analyzer
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

      fonts.fontconfig.enable = true;
      home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    };
}
