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

    # apps for this user
    ghostty
    zed-editor
    onlyoffice-desktopeditors
    evince
    bruno
    mpv
    freerdp
    vlc
    antigravity-fhs
    code-code-cursor-fhs
  ];
}
