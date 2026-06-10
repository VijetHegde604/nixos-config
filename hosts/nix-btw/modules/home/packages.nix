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
    inputs.helium-nix.packages.${pkgs.stdenv.hostPlatform.system}.default # Helium Browser from flakes
    zed-editor
    onlyoffice-desktopeditors
    evince
    bruno
    localsend
    mpv
    code-cursor
    freerdp
    vlc
  ];

  # KDE Connect 
  services.kdeconnect.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
