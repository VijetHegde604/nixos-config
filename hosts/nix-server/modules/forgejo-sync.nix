{ ... }:
{
  services.github-forgejo-mirror = {
    enable = true;
    environmentFile = "/etc/github-forgejo-mirror.env";

    # How often this program discovers repos and reconciles their settings.
    interval = "15m";
  };
}
