{ lib, pkgs, settings, ... }:

{
  services.greetd = lib.mkIf (settings.desktopEnvironment == "niri-dms") {
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

  programs.niri = lib.mkIf (settings.desktopEnvironment == "niri-dms") {
    enable = true;
    package = pkgs.niri;
  };

  services.desktopManager.cosmic.enable = settings.desktopEnvironment == "cosmic";
  services.displayManager.cosmic-greeter.enable = settings.desktopEnvironment == "cosmic";

  services.desktopManager.plasma6.enable = settings.desktopEnvironment == "kde-plasma";
  services.displayManager.sddm.enable = settings.desktopEnvironment == "kde-plasma";

  services.displayManager.autoLogin = {
    enable = true;
    user = settings.username;
  };

  programs.seahorse.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
