{ ... }:

{
  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.dbus.enable = true;

  services.gvfs.enable = true; # REQUIRED for trash, mtp, smb, auto-mount
  services.tumbler.enable = true; # thumbnails

  zramSwap = {
    enable = true;
    algorithm = "zstd"; # best default
    memoryPercent = 50; # 25–50% is ideal
    priority = 100; # higher = preferred over disk swap
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
}
