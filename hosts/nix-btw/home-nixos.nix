{ settings, lib, ... }:

{
  imports = [
    ./modules/home/starship.nix
    ./modules/home/shell.nix
    ./modules/home/git.nix
    ./modules/home/fastfetch.nix
    ./modules/home/packages.nix
    ./modules/home/ghostty.nix
    ./modules/home/xdg-user-dirs.nix
    ./modules/home/zed.nix
    ./modules/home/webapps.nix
  ]
  ++ lib.optionals (settings.desktopShell == "niri") [
    ./modules/home/niri/dms.nix
    ./modules/home/niri/niri-binds.nix
  ]
  ++ lib.optionals (settings.desktopShell == "mango") [
    ./modules/home/mango-wm/mangowm.nix
    ./modules/home/mango-wm/dms.nix

  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
