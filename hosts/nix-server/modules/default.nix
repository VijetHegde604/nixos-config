{ ... }:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./git.nix
    ./shell.nix
    ./ssh.nix
    ./docker.nix
    ./packages.nix
    ./nix.nix
    ./storage.nix
    ./hardware.nix
  ];
}
