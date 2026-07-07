{ ... }:

{
  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.accounts-daemon.enable = true;

  services.gvfs.enable = true; # REQUIRED for trash, mtp, smb, auto-mount
  services.tumbler.enable = true; # thumbnails

  zramSwap = {
    enable = true;
    algorithm = "lz4"; # lower latency than zstd for interactive zram swap
    memoryPercent = 100; # keep more pressure in fast compressed RAM before disk
    priority = 100; # higher = preferred over disk swap
  };

}
