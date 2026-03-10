{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hostname
  networking.hostName = "nix-server";

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable SSH so you can manage the server remotely
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Docker for running your services
  virtualisation.docker.enable = true;

  # User
  users.users.vijeth = {
    isNormalUser = true;
    description = "Vijet Hegde";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
    ];
    packages = with pkgs; [
      git
      tree
      vim
    ];
  };

  # Allow sudo
  security.sudo.wheelNeedsPassword = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      80 # HTTP
      443 # HTTPS
    ];
  };

  # Useful system packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
