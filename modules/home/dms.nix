{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri   # this activates the niri submodule
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;  # must be latest nixpkgs version (~25.11+)

    # Define settings early + explicitly to avoid null during eval
    settings = {
      layout = {
        border = {
          enable = false;  # ← key: disables the crashing condition
        };
      };
    };
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    niri = {
      # Do NOT set enableKeybinds = true; (conflicts with includes)
      # Do NOT set enableSpawn = true; (conflicts with systemd)

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
          "user"
          # "windowrules"
          # Skip "outputs" — DMS doesn't generate it for niri (known open issue)
        ];
      };
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };
}