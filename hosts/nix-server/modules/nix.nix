{ ... }:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
    };

    # gc = {
    #   automatic = true;
    #   dates = "daily";
    #   options = "--delete-older-than 14d";
    # };
  };

  # Enable nh (Nix Helper)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/vijeth/nixos-config";
  };

  # # Keep upgrades automatic but deterministic through pinned flake.lock.
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "github:VijetHegde604/nixos-config";
  };
}
