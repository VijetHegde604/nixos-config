{ ... }:

{
  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "100.95.4.126" "1.1.1.1" ];

  services.resolved.enable = true;
  services.tailscale.enable = true;
}
