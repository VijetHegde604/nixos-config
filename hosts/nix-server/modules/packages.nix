{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    bash-completion
    libsecret
    zoxide
    lsd
    lazygit
    bat

    # Development Tools
    gcc
    gnumake
    binutils
    pkg-config
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # common runtime deps mise builds need
    openssl
    zlib
    libffi
    readline
    xz
    cacert
  ];
}
