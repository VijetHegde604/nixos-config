{ ... }:

{
  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;

  networking.nameservers = [ "100.95.4.126" ];
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" ];
  };

  services.tailscale.enable = true;
}
