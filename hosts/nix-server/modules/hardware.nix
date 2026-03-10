{ pkgs, ... }:
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
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
      libva
      libva-utils
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
