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

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

}
