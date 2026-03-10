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

  systemd.services.sys-monitor-api = {
    description = "Python System Monitoring API";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "vijeth";
      WorkingDirectory = "/home/vijeth/system-monitor-api";

      ExecStart = "/home/vijeth/system-monitor-api/.venv/bin/python /home/vijeth/system-monitor-api/system-monitor.py";

      Restart = "always";
      RestartSec = 5;

      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
  };

}
