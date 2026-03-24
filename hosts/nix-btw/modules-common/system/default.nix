{ ... }:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./desktop.nix
    ./hardware.nix
    ./packages.nix
    ./services.nix
    ./nix.nix
    ./syncthing.nix
    # ./virtualization.nix
  ];
}
