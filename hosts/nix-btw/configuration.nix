{
  inputs,
  lib,
  pkgs,
  settings,
  ...
}:

{
  imports = [
    (inputs.import-tree ./modules/system)
  ]
  ++ lib.optional settings.virtualization ./modules/_virtualization/virtualization.nix
  ++ lib.optional settings.gaming ./modules/_gaming/steam.nix;

  users.users.vijeth = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    packages = with pkgs; [ tree ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."vijeth" = import ./home.nix;
  };

  system.stateVersion = settings.systemVersion;
}
