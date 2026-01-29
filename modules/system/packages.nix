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
];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
  ];

  programs.firefox.enable = true;
}
