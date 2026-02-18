{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    ./modules-common/system/boot.nix
    ./modules-common/system/networking.nix
    ./modules-common/system/locale.nix
    ./modules-common/system/desktop.nix
    ./modules-common/system/hardware.nix
    ./modules-common/system/packages.nix
    ./modules-common/system/services.nix
    # ./modules/system/virtualization.nix
  ];

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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."vijeth" = import ./home-nixos.nix;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
