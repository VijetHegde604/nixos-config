{ settings, ... }:

{
  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;

  # opened ports for KDE Connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  networking.nameservers = [ "100.95.4.126" ];
  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        FallbackDns = [ "1.1.1.1" ];
      };
    };
  };

  services.tailscale.enable = true;
}
