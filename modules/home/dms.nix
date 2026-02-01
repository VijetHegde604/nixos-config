{ inputs, pkgs, ... }: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    # NO inputs.dms.homeModules.niri — repo never had a separate one; it's integrated
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;  # or pkgs.niri-unstable if you prefer even fresher
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };

    niri.includes = {
      enable = true;
      override = true;
      originalFileName = "hm";  # renames any conflicting config
      filesToInclude = [
        "alttab"
        "binds"      # ← populates keybinds
        "colors"
        "layout"
        "outputs"
        "wpblur"
      ];
    };
  };
}