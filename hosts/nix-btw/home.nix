{
  settings,
  lib,
  inputs,
  ...
}:

{
  imports = [
    (inputs.import-tree ./modules/home)
  ]
  ++ lib.optionals (settings.desktopShell == "niri") [
    ./modules/home/_dms/dms.nix
    ./modules/home/_dms/niri-binds.nix
  ]
  ++ lib.optionals (settings.desktopShell == "noctalia") [
    ./modules/home/_noctalia/noctalia.nix
    ./modules/home/_noctalia/niri_binds.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
