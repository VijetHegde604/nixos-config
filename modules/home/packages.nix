{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    btop
    mise
    starship
    zoxide
    lsd
    lazygit
    ripgrep
    fd
    bat
    duf

    # terminal and apps for this user
    ghostty
    brave
    zed-editor
    vscode
    wtype

    # your API tool
    bruno
  ];
}
