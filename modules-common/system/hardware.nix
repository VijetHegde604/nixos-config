{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.libinput.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.acpid.enable = true;
  services.thermald.enable = true;

  systemd.services.battery-threshold = {
    description = "Set battery charge threshold";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
      RemainAfterExit = true;
    };
  };
}
