{ ... }:
{
  networking = {
    hostName = "nix-server";

    networkmanager.enable = false;

    interfaces.enp2s0.useDHCP = false;

    interfaces.enp2s0.ipv4.addresses = [
      {
        address = "192.168.1.70";
        prefixLength = 24;
      }
    ];

    defaultGateway.address = "192.168.1.1";

    nameservers = [
      "192.168.1.69"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        80 # HTTP
        443 # HTTPS
      ];
    };
  };

  services.tailscale.enable = true;
}
