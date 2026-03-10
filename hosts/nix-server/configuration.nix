{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/docker.nix
    ./modules/packages.nix
    ./modules/nix.nix
    ./modules/storage.nix
  ];

  system.stateVersion = "25.11";
}
