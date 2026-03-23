{ settings, ... }:

{
  imports = [
    ./modules-common/home/starship.nix
    ./modules-common/home/shell.nix
    ./modules-common/home/git.nix
    ./modules-common/home/fastfetch.nix
    ./modules-common/home/packages.nix
    ./modules-common/home/dms.nix
    ./modules-common/home/niri-binds.nix
    ./modules-common/home/ghostty.nix
    ./modules-common/home/xdg-user-dirs.nix
    ./modules-common/home/create-webapp.nix
    ./modules-common/home/zed.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
