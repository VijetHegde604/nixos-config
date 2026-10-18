{
  lib,
  settings,
  inputs,
  ...
}:

{
  imports = [
    (inputs.import-tree ./modules/home)
  ]
  ++ lib.optional (settings.desktopEnvironment == "niri-dms") ./modules/home/_dms/dms.nix
  ++ lib.optional (settings.desktopEnvironment == "niri-dms") ./modules/home/_dms/niri-binds.nix;

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
