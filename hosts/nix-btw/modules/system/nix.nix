{ settings, ... }:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
      connect-timeout = 5;
    };

  };

  nixpkgs.config.allowUnfree = true;

  # Enable nh (Nix Helper)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = settings.configRepoPath;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "github:VijetHegde604/nixos-config";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
  };
}
