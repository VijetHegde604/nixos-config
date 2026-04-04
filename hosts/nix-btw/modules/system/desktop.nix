{ pkgs, ... }:

{

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "vijeth";
      };
      default_session = {
        command = "${pkgs.bash}/bin/sh";
        user = "vijeth";
      };
    };
  };

  programs.niri = {
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
