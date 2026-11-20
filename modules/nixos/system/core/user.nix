{ config, lib, ... }:
let
  flakeConfig = config;
  defaultPasswd = "$y$j9T$ipvG2WZD.A/83SCUj9aeo1$evxg1lo.SLhpMDB5r/K/4xm/3M6M2pCcKyKGWVM4LGA";
in
{
  flake.modules.nixos.user = { config, pkgs, ... }: {
    programs.zsh.enable = true;

    users = {
      mutableUsers = true;
      defaultUserShell = pkgs.zsh;

      users = {
        root = {
          isSystemUser = true;
          hashedPassword = defaultPasswd;
        };

        ${flakeConfig.user.username} = {
          isNormalUser = true;
          description = flakeConfig.user.username;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          hashedPassword = defaultPasswd;
        };
      };
    };
  };
}
