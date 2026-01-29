{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
              ./hardware-configuration.nix
              inputs.home-manager.nixosModules.home-manager
            ];

  # --- Bootloader & Kernel ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --- Networking ---
  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  services.tailscale.enable = true;

  # --- Localization ---
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Window Manager & Desktop Services ---
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;      
  
  programs.niri.enable = true;
  programs.dms-shell.enable = true; # Dank Material Shell
  programs.seahorse.enable = true;

  # XDG Portals Configuration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    xdgOpenUsePortal = true;
  };

  # --- Hardware & Sound ---
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

  # --- User Account ---
  users.users.vijeth = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [ tree ];
  };  

  # -- Home Manager --
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "vijeth" = import ./home.nix;
    };
  };

  # --- System Packages ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # Terminal & CLI Tools
    vim nano fastfetch ghostty btop mise starship 
    zoxide lsd git wtype bash-completion lazygit
    libsecret ripgrep fd bat gnome-keyring
    
    # GUI Apps
    brave nautilus 
    seahorse zed-editor vscode 
    
    # Icon Themes 
    papirus-icon-theme
    adwaita-icon-theme
    xdg-user-dirs
  ];

  # --- Fonts ---
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # --- Misc Services ---
  services.gnome.gnome-keyring.enable = true;
  programs.firefox.enable = true;


  system.stateVersion = "25.11"; 
}
