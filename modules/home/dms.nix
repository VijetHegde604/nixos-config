{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri.homeModules.niri

    # Required by DMS HM module:
    # It unconditionally reads this path during eval
    ./user/niri-compat.nix
  ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
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
          "binds"
          "colors"
          "layout"
          "wpblur"
          "cursor"
          "outputs"

          # user overrides (explicit files!)
          "user/overrides"
          "user/binds"
        ];
      };
    };
  };
}
