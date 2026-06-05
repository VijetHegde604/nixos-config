{ pkgs, settings, ... }:

{
  boot.loader = {
    limine.enable = true;
    limine.secureBoot.enable = if settings.secureBoot then true else false;
    efi.canTouchEfiVariables = true;
  };

  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable systemd in initrd
  boot.initrd.systemd.enable = true;

  # Force Graphics Drivers into initrd
  boot.initrd.kernelModules = [ "i915" ];

  boot.plymouth = {
    enable = true;
    theme = settings.plymouthTheme;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ settings.plymouthTheme ];
      })
    ];
  };

  # Enhanced Silent Boot & Logistics
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # 4. Ensure the display is initialized early
  boot.initrd.systemd.extraBin = {
    # Helpful for debugging, but not strictly required
    # ls = "${pkgs.coreutils}/bin/ls";
  };

  #  system.activationScripts.postInstallConfig = {
  #    text = builtins.readFile ./post-install.sh;
  #    deps = [ ];
  #  };
}
