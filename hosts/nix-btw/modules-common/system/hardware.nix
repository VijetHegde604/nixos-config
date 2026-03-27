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

  # ------- Graphics Settings -------- #

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "i915.enable_guc=3" ];

  # -------# -------# -------# -------# -------# -------# -------# -------# -------# -------#

  services.libinput.enable = true;
  services.upower.enable = true;
  services.acpid.enable = true;

  services.thermald.enable = true;
  services.throttled.enable = true;

  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "powersave";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #     CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

  #     PLATFORM_PROFILE_ON_AC = "performance";
  #     PLATFORM_PROFILE_ON_BAT = "low-power";

  #     INTEL_GPU_MIN_FREQ_ON_AC = 300;
  #     INTEL_GPU_MAX_FREQ_ON_AC = 1300; # 12500H Max iGPU clock
  #     INTEL_GPU_MIN_FREQ_ON_BAT = 300;
  #     INTEL_GPU_MAX_FREQ_ON_BAT = 800;
  #   };
  # };
  #

  services.power-profiles-daemon.enable = true;

  services.system76-scheduler.settings.cfsProfiles.enable = true;

  networking.networkmanager.wifi.powersave = false;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  # Keep battery wear lower on supported laptops.
  systemd.services.battery-threshold = {
    description = "Set battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    unitConfig.ConditionPathExists = "/sys/class/power_supply/BAT0/charge_control_end_threshold";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
      RemainAfterExit = true;
    };
  };
}
