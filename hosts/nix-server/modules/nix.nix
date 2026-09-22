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
  };

  nixpkgs-stable.config.allowUnfree = true;

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
    dates = "Sun 03:00";
    flake = "github:VijetHegde604/nixos-config";
    allowReboot = true;
  };
}
