{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

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
  ];

  programs.firefox.enable = true;
}
