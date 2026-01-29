{ config, pkgs, ... }:

{
  imports = [
    ./modules/home/starship.nix
    ./modules/home/shell.nix
    ./modules/home/git.nix
  ];

  home.username = "vijeth";
  home.homeDirectory = "/home/vijeth";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
