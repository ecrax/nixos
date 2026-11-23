{ inputs, config, ... }:
{
  flake.modules.nixos.musnix = {
    imports = [ inputs.musnix.nixosModules.musnix ];

    musnix.enable = true;

    users.users.${config.user.username}.extraGroups = [
      "audio"
    ];
  };
}
