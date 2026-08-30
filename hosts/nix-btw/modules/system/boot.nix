{ pkgs, settings, ... }:

{
  boot.loader = {
    limine.enable = true;
    limine.secureBoot.enable = settings.secureBoot;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
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

}
