{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri.homeModules.niri
    inputs.danksearch.homeModules.dsearch
    inputs.dms-plugin-registry.modules.default

    # Required by DMS HM module:
    # It unconditionally reads this path during eval
    ./user/niri-compat.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dsearch = {
    enable = true;
  };

  programs.dank-material-shell = {
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

          # user overrides (explicit files!)
          "user/overrides"
        ];
      };
    };

    plugins = {
      dankPomodoroTimer.enable = true;
    };
  };
}
