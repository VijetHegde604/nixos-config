{ ... }:
{

  services.immich = {
    enable = true;
    port = 2284;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/home/vijeth/immich";
    accelerationDevices = null;
  };
}
