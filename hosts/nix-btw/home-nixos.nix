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
  ++ lib.optionals (settings.desktopShell == "dms") [
    ./modules/home/dms/dms.nix
    ./modules/home/dms/niri-binds.nix
  ]
  ++ lib.optionals (settings.desktopShell == "noctalia") [
    ./modules/home/noctalia/noctalia.nix
    #./modules/home/noctalia/niri-binds.nix
    ./modules/home/noctalia/niri-settings.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
