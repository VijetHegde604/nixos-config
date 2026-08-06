{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri-flake.homeModules.niri
    inputs.vicinae.homeManagerModules.default

    # Required by DMS HM module:
    # It unconditionally reads this path during eval
    ./user/niri-compat.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.vicinae = {
    enable = true;
    package = pkgs.vicinae;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      nix
    ];
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
          "binds"

          # user overrides (explicit files!)
          "user/overrides"
        ];
      };
    };
  };
}
