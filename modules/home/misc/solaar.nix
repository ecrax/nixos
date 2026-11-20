# Logitech device management
{
  flake.modules.homeManager.solaar =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        solaar
      ];
    };
}
