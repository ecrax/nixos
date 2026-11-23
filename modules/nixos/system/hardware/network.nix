{
  flake.modules.nixos.network =
    { pkgs, ... }:
    {
      networking.networkmanager.enable = true;
      services.vnstat.enable = true;
      environment.systemPackages = with pkgs; [
        python313Packages.dbus-python
      ];

      # Firewall
      networking.firewall.enable = true;
      networking.nftables.enable = true;

      services.firewalld = {
        enable = true;
        # Optional for NetworkManager, block inbound connections for new/public/untrusted WiFi connections
        settings.DefaultZone = "drop";
      };
    };
}
