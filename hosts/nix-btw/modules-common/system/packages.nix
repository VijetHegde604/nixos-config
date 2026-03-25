{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    bash-completion
    libsecret
    gnome-keyring
    nautilus
    papirus-icon-theme
    adwaita-icon-theme
    xdg-user-dirs
    xwayland-satellite
    cups-pk-helper
    btrfs-assistant
    sbctl
    efibootmgr
    distrobox
    distrobox-tui

    # Development Tools
    gcc
    gnumake
    binutils
    pkg-config
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # common runtime deps mise builds need
    openssl
    zlib
    libffi
    readline
    xz
    cacert
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    cantarell-fonts
    inter
  ];

  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  # Adding podman for distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
