{ inputs, pkgs, settings, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings.spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar.widgets.left = [
        { id = "Launcher"; }
        { id = "Clock"; }
        { id = "ActiveWindow"; }
      ];
      bar.widgets.center = [
        { id = "Workspace"; }
      ];
      bar.widgets.right = [
        { id = "Tray"; }
        { id = "NotificationHistory"; }
        { id = "Battery"; }
        { id = "Volume"; }
        { id = "Brightness"; }
        { id = "ControlCenter"; }
      ];
      general.avatarImage = "/home/${settings.username}/.face";
      location = {
        name = "Bengaluru, India";
        useFahrenheit = false;
        use12hourFormat = false;
      };
    };
  };
}
