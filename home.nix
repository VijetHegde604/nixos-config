{ config, pkgs, ... }:

{
  imports = [
    ./modules/home/starship.nix
    ./modules/home/shell.nix
    ./modules/home/git.nix
    ./modules/home/fastfetch.nix
    ./modules/home/packages.nix
    ./modules/home/dms.nix
    ./modules/home/ghostty.nix
    ./modules/home/user/webapps.nix # This should be imported before pwa.nix
    ./modules/home/pwa.nix
  ];

  home.username = "vijeth";
  home.homeDirectory = "/home/vijeth";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
