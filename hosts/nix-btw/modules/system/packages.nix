{ pkgs, inputs, ... }:

{
  import = [
    inputs.nix-flatpak.nixosModule.nix-flatpak
  ];

  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    bash-completion
    libsecret
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
    nix-output-monitor
    nvd

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

  services.flatpak = {
    enable = true;
    packages = [
      {
        appId = "org.jellyfin.JellyfinDesktop";
        origin = "flathub";
      }
    ];
  };

  # Adding podman for distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
