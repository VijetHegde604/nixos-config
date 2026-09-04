{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    btop
    zoxide
    lsd
    lazygit
    ripgrep
    fd
    bat
    duf
    nil
    nixd
    neovim
    wtype
    fzf
    wget
    ouch
    zellij
    adw-gtk3

    # apps for this user
    onlyoffice-desktopeditors
    evince
    bruno
    mpv
    freerdp
    vlc
    antigravity-ide-fhs
    code-cursor-fhs
    inputs.helium.packages.${stdenv.hostPlatform.system}.default # helium browser from flake
    jellyfin-desktop
  ];
}
