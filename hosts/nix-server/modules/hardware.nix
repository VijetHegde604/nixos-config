{ ... }:
{
  services.acpid.enable = true;
  services.thermald.enable = true;
  services.fstrim.enable = true;
  services.tlp.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
