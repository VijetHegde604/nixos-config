{ ... }:
{
  imports = [
    ./modules-common/home/git.nix
    ./modules-common/home/fastfetch.nix
    ./modules-common/home/starship.nix
    ./modules-common/home/xdg-user-dirs.nix
    ./modules-common/home/create-webapp.nix

    ./modules-portable/packages.nix
    ./modules-portable/ghostty.nix
    ./modules-portable/shell.nix
    ./modules-portable/zed-config.nix
  ];

  home.username = "vijeth";
  home.homeDirectory = "/home/vijeth";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
