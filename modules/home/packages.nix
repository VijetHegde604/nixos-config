{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    btop
    starship
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
    code-cursor

    # apps for this user
    ghostty
    inputs.helium-nix.packages.${pkgs.stdenv.hostPlatform.system}.default # Helium Browser from flakes
    zed-editor
    wtype
    onlyoffice-desktopeditors
    jellyfin-desktop
    evince
    bruno
    localsend
    mpv
    telegram-desktop
  ];
}
