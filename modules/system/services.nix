{ ... }:

{
  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.dbus.enable = true;

  services.gvfs.enable = true;   # REQUIRED for trash, mtp, smb, auto-mount
  services.tumbler.enable = true; # thumbnails 

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
}
