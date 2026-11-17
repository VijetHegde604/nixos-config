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
    (inputs.import-tree ./modules/system)
  ]
  ++ lib.optional (settings.desktopEnvironment == "mango-dms") inputs.mangowm.nixosModules.mango
  ++ lib.optional (settings.desktopEnvironment == "umbriel-noctalia") inputs.umbriel.nixosModules.default
  ++ lib.optional (builtins.elem settings.desktopEnvironment [ "niri-noctalia" "umbriel-noctalia" ]) inputs.noctalia.nixosModules.default
  ++ lib.optional settings.virtualization ./modules/_virtualization/virtualization.nix
  ++ lib.optional settings.gaming ./modules/_gaming/steam.nix;

  # Enable zsh system-wide (adds it to /etc/shells)
  programs.zsh.enable = true;

  users.users.vijeth = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    packages = with pkgs; [ tree ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."vijeth" = import ./home.nix;
  };

  system.stateVersion = settings.systemVersion;
}
