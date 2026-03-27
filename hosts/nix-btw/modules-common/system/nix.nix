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
      connect-timeout = 5;
      extra-substituters = [
        "https://cache.garnix.io"
        "https://attic.xuyh0120.win/lantian"
      ];
      extra-trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # Keep upgrades automatic but deterministic through pinned flake.lock.
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
