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
  ++ lib.optional (builtins.elem settings.desktopEnvironment [ "niri-dms" "niri-noctalia" ]) ./modules/home/_dms/niri-binds.nix
  ++ lib.optional (settings.desktopEnvironment == "niri-noctalia") ./modules/home/_noctalia/niri.nix
  ++ lib.optional (builtins.elem settings.desktopEnvironment [ "niri-noctalia" "umbriel-noctalia" ]) ./modules/home/_noctalia/noctalia.nix
  ++ lib.optional (settings.desktopEnvironment == "umbriel-noctalia") ./modules/home/_noctalia/umbriel.nix
  ++ lib.optional (settings.desktopEnvironment == "mango-dms") ./modules/home/_dms/mango-dms.nix;

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
