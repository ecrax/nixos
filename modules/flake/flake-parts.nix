{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  _module.args.homeAspects = lib.mapAttrs (name: module: {
    key = "home#aspects.${name}";
    imports = [ module ];
  }) config.flake.modules.homeManager;

  _module.args.systemAspects = lib.mapAttrs (name: module: {
    key = "system#aspects.${name}";
    imports = [ module ];
  }) config.flake.modules.nixos;
}
