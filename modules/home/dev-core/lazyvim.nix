{
  inputs,
  homeAspects,
  ...
}:
{
  flake.modules.homeManager.lazyvim =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [ homeAspects.dev-pkgs inputs.lazyvim.homeManagerModules.default ];
      programs.lazyvim = {
        enable = true;

        extras = {
          util.project.enable = true;
          lang.nix.enable = true;
          lang.json.enable = true;
          lang.rust.enable = true;
          lang.python = {
            enable = true;
            installDependencies = true;        # Install ruff
            installRuntimeDependencies = false; # Install python3
          };
          lang.go = {
            enable = true;
            installDependencies = true;        # Install gopls, gofumpt, etc.
            installRuntimeDependencies = false; # Install go compiler
          };
          lang.typescript = {
            enable = true;
            installDependencies = false;        # Skip typescript tools
            installRuntimeDependencies = false;  # But install nodejs
          };
        };

        # Additional packages (optional)
        extraPackages = with pkgs; [
          nixd       # Nix LSP
          alejandra  # Nix formatter
        ];

        # # Only needed for languages not covered by LazyVim extras
        # treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        #   wgsl      # WebGPU Shading Language
        #   templ     # Go templ files
        # ];
      };
    };
}
