{ ... }:
{
  fileSystems."/media" = {
    device = "/dev/disk/by-uuid/2d5c48cf-c227-48d2-bc09-2776d87a2128";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=5"
    ];
  };

  fileSystems."/backup" = {
    device = "/dev/disk/by-uuid/91b6d39e-74e5-493f-a279-f8586f59cf53";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=5"
    ];
  };
}
