{ ... }:
{
  users.users.vijeth = {
    isNormalUser = true;
    description = "Vijet Hegde";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
    ];
  };
  security.sudo.wheelNeedsPassword = true;
}
