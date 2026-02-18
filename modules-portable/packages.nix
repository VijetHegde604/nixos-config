{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
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
    wtype
  ];
}
