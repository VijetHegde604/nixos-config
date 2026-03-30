{
  pkgs,
  inputs,
  lib,
  settings,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules-common/system/boot.nix
    ./modules-common/system/networking.nix
    ./modules-common/system/locale.nix
    ./modules-common/system/desktop.nix
    ./modules-common/system/hardware.nix
    ./modules-common/system/packages.nix
    ./modules-common/system/services.nix
    ./modules-common/system/nix.nix
    ./modules-common/system/syncthing.nix
  ]
  ++ lib.optional settings.virtualization ./modules-common/system/virtualization.nix;

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
    users."vijeth" = import ./home-nixos.nix;
  };

  system.stateVersion = "25.11";
}
