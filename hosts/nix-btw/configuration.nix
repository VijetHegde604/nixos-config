{
  inputs,
  lib,
  pkgs,
  settings,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/boot.nix
    ./modules/system/networking.nix
    ./modules/system/locale.nix
    ./modules/system/desktop.nix
    ./modules/system/hardware.nix
    ./modules/system/packages.nix
    ./modules/system/services.nix
    ./modules/system/nix.nix
    #./modules/system/syncthing.nix
  ]
  ++ lib.optional settings.virtualization ./modules/system/virtualization.nix
  ++ lib.optional settings.gaming ./modules/system/steam.nix
  ++ lib.optional (settings.desktopShell == "mango") ./modules/home/mango-wm/mangowm.nix;

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
