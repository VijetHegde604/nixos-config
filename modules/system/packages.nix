{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim nano fastfetch ghostty btop mise starship 
    zoxide lsd git wtype bash-completion lazygit
    libsecret ripgrep fd bat gnome-keyring

    brave nautilus 
    seahorse zed-editor vscode 

    papirus-icon-theme
    adwaita-icon-theme
    xdg-user-dirs
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.firefox.enable = true;
}
