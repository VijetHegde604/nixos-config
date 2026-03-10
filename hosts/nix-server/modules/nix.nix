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

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # # Keep upgrades automatic but deterministic through pinned flake.lock.
  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "weekly";
  #   flake = "github:VijetHegde604/nixos-config";
  #   flags = [
  #     "--update-input"
  #     "nixpkgs"
  #   ];
  # };
}
