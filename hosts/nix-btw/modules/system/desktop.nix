{ lib, pkgs, settings, ... }:

let
  desktopShell = settings.desktopShell or "dms";
  useNiri = builtins.elem desktopShell [
    "dms"
    "noctalia"
  ];
  usePlasma = desktopShell == "plasma";
in
{
  services.greetd = lib.mkIf useNiri {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = settings.username;
      };
      default_session = {
        command = "${pkgs.bash}/bin/sh";
        user = settings.username;
      };
    };
  };

  programs.niri = lib.mkIf useNiri {
    enable = true;
    package = pkgs.niri;
  };

  programs.seahorse.enable = lib.mkIf useNiri true;

  services.displayManager.sddm.enable = usePlasma;
  services.desktopManager.plasma6.enable = usePlasma;

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
