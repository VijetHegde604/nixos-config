{ settings, ... }:
{
  imports = [
    ./modules-common/home
    ./modules-portable
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
