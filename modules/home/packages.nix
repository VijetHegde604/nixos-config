{ pkgs, ... }:
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

    # apps for this user
    ghostty
    brave
    zed-editor
    vscode
    wtype
    onlyoffice-desktopeditors
    jellyfin-desktop
    evince
    bruno
    localsend
  ];
}
