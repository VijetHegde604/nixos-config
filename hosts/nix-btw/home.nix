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
    ./modules/home/_niri/dms.nix
    ./modules/home/_niri/niri-binds.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
