{ lib, pkgs, settings, ... }:

let
  desktopShell = settings.desktopShell or "dms";
  usePlasma = desktopShell == "kde-plasma";
  useNiri = builtins.elem desktopShell [
    "dms"
    "noctalia"
  ];
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

  services.xserver.enable = lib.mkIf usePlasma true;
  services.displayManager.plasma-login-manager.enable = lib.mkIf usePlasma true;
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = settings.username;
  };
  services.desktopManager.plasma6.enable = lib.mkIf usePlasma true;

  programs.niri = lib.mkIf useNiri {
    enable = true;
    package = pkgs.niri;
  };

  programs.seahorse.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
