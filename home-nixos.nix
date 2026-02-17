{ config, pkgs, ... }:

{
  imports = [
    ./modules-common/home/starship.nix
    ./modules-common/home/shell.nix
    ./modules-common/home/git.nix
    ./modules-common/home/fastfetch.nix
    ./modules-common/home/packages.nix
    ./modules-common/home/dms.nix
    ./modules-common/home/ghostty.nix
    ./modules-common/home/xdg-user-dirs.nix
    ./modules-common/home/create-webapp.nix
  ];

  home.username = "vijeth";
  home.homeDirectory = "/home/vijeth";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
