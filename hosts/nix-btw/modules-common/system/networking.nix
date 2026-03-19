{ settings, ... }:

{
  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;

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
