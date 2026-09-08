{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
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

    # Keep the general-purpose build and Python tooling available outside
    # project-specific development shells.
    gcc
    gnumake
    binutils
    pkg-config
    python3
    python3Packages.pip
    python3Packages.virtualenv
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
    inter
    fira-code
  ];

  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services.flatpak = {
    enable = true;
    packages = [
      {
        appId = "org.jellyfin.JellyfinDesktop";
        origin = "flathub";
      }
    ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
