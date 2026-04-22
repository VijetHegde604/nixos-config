{ settings, ... }:
{
  imports = [
    ./modules/home/git.nix
    ./modules/home/fastfetch.nix
    ./modules/home/starship.nix
    ./modules/home/xdg-user-dirs.nix
    ./modules/home/create-webapp.nix

    ./modules-portable/packages.nix
    ./modules-portable/ghostty.nix
    ./modules-portable/shell.nix
    ./modules-portable/zed-config.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "25.11";
  news.display = "silent";

  programs.home-manager.enable = true;
}
