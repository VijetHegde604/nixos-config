{ ... }:

{
  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.accounts-daemon.enable = true;

  services.gvfs.enable = true; # REQUIRED for trash, mtp, smb, auto-mount
  services.tumbler.enable = true; # thumbnails

  services.fstrim.enable = true;
  

}
