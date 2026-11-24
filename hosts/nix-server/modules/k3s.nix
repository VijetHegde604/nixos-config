{pkgs, lib, config, ...}:
{
#   networking.firewall.allowedTCPPorts = [6443];
#   networking.firewall.allowedUDPPorts = [8472];
#
#   services.k3s = {
#     enable = true;
#     role = "server";
#     extraFlags = toString [
#       "--debug"
#     ];
#   };
}
