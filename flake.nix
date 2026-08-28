{
  description = "Vijet's unified NixOS + Home Manager config";

  # Ensure first rebuild on a fresh install can pull CachyOS kernel binaries.
  nixConfig = {
    extra-substituters = [
      "https://vicinae.cachix.org"
      "https://nyx-cache.chaotic.cx/"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # chaotic nyx

    import-tree.url = "github:denful/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    niri-flake.url = "github:sodiboo/niri-flake";
    niri-flake.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions.url = "github:vicinaehq/extensions";
    vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      chaotic,
      ...
    }:
    let
      system = "x86_64-linux";

      nixBtwSettings = import ./hosts/nix-btw/settings.nix;
      nixServerSettings = import ./hosts/nix-server/settings.nix;
    in
    {
      # -------------------------
      # NixOS configuration
      # -------------------------
      nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          settings = nixBtwSettings;
        };

        modules = [
          ./hosts/nix-btw/configuration.nix

          chaotic.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              settings = nixBtwSettings;
            };
          }
        ];
      };

      # ---------------------------------
      # Nix Server Configuration
      # ---------------------------------
      nixosConfigurations.nix-server = inputs.nixpkgs-stable.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          settings = nixServerSettings;
        };

        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./hosts/nix-server/configuration.nix
        ];
      };
    };
}
