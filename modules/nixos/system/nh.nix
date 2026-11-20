{ config, lib, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.nixos.nh =
    { config, pkgs, ... }:
    {
      programs.nh = {
        enable = true;
        # flake = "${config.users.users.${flakeConfig.user.username}.home}/.config/nixos-config";
        flake = "/etc/nixos";
        clean = {
          enable = lib.mkDefault true;
          dates = "weekly";
          extraArgs = "--keep-since 7d --keep 3 --optimise";
        };
      };
    };
}
