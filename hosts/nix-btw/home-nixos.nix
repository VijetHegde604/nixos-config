{ settings, lib, ... }:

let
  niriShells = [
    "dms"
    "noctalia"
  ];
  useNiriShell = lib.elem settings.desktopShell niriShells;
in
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
  ++ lib.optionals useNiriShell (
    [ ./modules/home/niri/niri-binds.nix ]
    ++ lib.optional (settings.desktopShell == "noctalia") ./modules/home/niri/noctalia.nix
    ++ lib.optional (settings.desktopShell == "dms") ./modules/home/niri/dms.nix
  );

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
