{ lib, pkgs, settings, ... }:

let
  desktopShell = settings.desktopShell or "dms";
  useCosmic = desktopShell == "cosmic";
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

  services.displayManager.cosmic-greeter.enable = lib.mkIf useCosmic true;
  services.desktopManager.cosmic.enable = lib.mkIf useCosmic true;

  programs.niri = lib.mkIf useNiri {
    enable = true;
    package = pkgs.niri;
  };

  programs.seahorse.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
