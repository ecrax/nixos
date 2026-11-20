{
  flake.modules.nixos.network =
    { pkgs, ... }:
    {
      networking.networkmanager.enable = true;
      services.vnstat.enable = true;
      environment.systemPackages = with pkgs; [
        python313Packages.dbus-python
        networkmanagerapplet
      ];

      # Firewall
      # TODO: switch to nftables and add frontend
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
        ];
        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      };
    };
}
