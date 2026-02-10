{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    btop
    mise
    uv
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
    yt-dlp

    # apps for this user
    ghostty
    inputs.helium-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    zed-editor
    wtype
    onlyoffice-desktopeditors
    jellyfin-desktop
    evince
    bruno
    localsend
    mpv
  ];
}
