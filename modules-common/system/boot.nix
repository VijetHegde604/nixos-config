{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  plymouth.enable = true;
  # Enable "Silent boot"
  consoleLogLevel = 3;
  initrd.verbose = false;
  kernelParams = [
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];
}
