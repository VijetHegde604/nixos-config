{ inputs, lib, pkgs, settings, ... }:

let
  shellChoice = settings.desktopShell or "dms";
in
{
  imports =
    [
      inputs.niri-flake.homeModules.niri

      # Required by DMS HM module:
      # It unconditionally reads this path during eval
      ./user/niri-compat.nix
    ]
    ++ lib.optionals (shellChoice == "dms") [
      inputs.dms.homeModules.dank-material-shell
      inputs.dms.homeModules.niri
      inputs.danksearch.homeModules.dsearch
      inputs.dms-plugin-registry.modules.default
    ]
    ++ lib.optionals (shellChoice == "noctalia") [
      inputs.noctalia.homeModules.default
    ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dsearch = lib.mkIf (shellChoice == "dms") {
    enable = true;
  };

  programs.dank-material-shell = lib.mkIf (shellChoice == "dms") {
    enable = true;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    niri = {
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";

        filesToInclude = [
          "alttab"
          "colors"
          "layout"
          "wpblur"
          "cursor"
          "outputs"
          "windowrules"
          "binds"

          # user overrides (explicit files!)
          "user/overrides"
        ];
      };
    };

    plugins = {
      dankPomodoroTimer.enable = true;
    };
  };

  programs.noctalia-shell = lib.mkIf (shellChoice == "noctalia") {
    enable = true;
    systemd.enable = true;

    settings = {
      general = {
        animationSpeed = 1.0;
      };
      colorSchemes = {
        useWallpaperColors = true;
      };
    };
  };
}
