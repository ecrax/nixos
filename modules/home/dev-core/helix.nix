{
  inputs,
  homeAspects,
  ...
}:
{
  flake.modules.homeManager.helix =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [ homeAspects.pkgs-dev ];
      programs.helix = {
        enable = true;
        settings = {
          theme = "material_deep_ocean";
          editor.cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
        # example config
        # configure using: https://github.com/helix-editor/helix/wiki/Language-Server-Configurations
        languages.language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt;
          }
        ];
      };
    };
}
