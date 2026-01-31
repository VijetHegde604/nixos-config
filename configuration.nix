{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    .//hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    ./modules/system/boot.nix
    ./modules/system/networking.nix
    ./modules/system/locale.nix
    ./modules/system/desktop.nix
    ./modules/system/hardware.nix
    ./modules/system/packages.nix
    ./modules/system/services.nix
  ];

  users.users.vijeth = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [ tree ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."vijeth" = import ./home.nix;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
