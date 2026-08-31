{ pkgs, ... }:

{
  # --- Bluetooth Configuration  ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
        FastConnectable = true;
        JustWorksRepairing = "always";
      };
    };
  };

  # --- Audio & PipeWire ---
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    # Enable high-quality codecs
    extraConfig.pipewire = {
      "10-codecs" = {
        "context.properties" = {
          "bluetooth.codecs" = [
            "sbc_xq"
            "aac"
            "ldac"
            "aptx_hd"
            "aptx"
            "sbc"
          ];
        };
      };
    };
  };

  # --- Graphics ---
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
  # --- Power management ---
  services.libinput.enable = true;
  services.upower.enable = true;
  services.acpid.enable = true;
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.enableAllFirmware = true;

  # --- Required Packages for DMS Codecs ---
  environment.systemPackages = with pkgs; [
    ldacbt
    bluez-tools
    pavucontrol
  ];

  # Battery threshold for BAT0
systemd.services.battery-threshold = {
  description = "Set battery charge threshold";

  wantedBy = [ "multi-user.target" ];

  after = [
    "sysinit.target"
    "systemd-modules-load.service"
  ];

  serviceConfig = {
    Type = "oneshot";

    ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 1 && echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";

    RemainAfterExit = true;
  };
};
}
