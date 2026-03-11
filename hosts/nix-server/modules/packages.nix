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
    fastfetch
    cockpit
    btop
    intel-gpu-tools


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

  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
}
