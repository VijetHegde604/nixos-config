{
  description = "Vijet's unified NixOS + Home Manager config";

  # Ensure first rebuild on a fresh install can pull CachyOS kernel binaries.
  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://attic.xuyh0120.win/lantian"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake.url = "github:sodiboo/niri-flake";
    niri-flake.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    danksearch.url = "github:AvengeMedia/danksearch";
    danksearch.inputs.nixpkgs.follows = "nixpkgs";

    dms-plugin-registry.url = "github:AvengeMedia/dms-plugin-registry";
    dms-plugin-registry.inputs.nixpkgs.follows = "nixpkgs";

    helium-nix.url = "github:AlvaroParker/helium-nix";
    helium-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions.url = "github:vicinaehq/extensions";
    vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      nixBtwSettings = import ./hosts/nix-btw/settings.nix;
      nixServerSettings = import ./hosts/nix-server/settings.nix;

      mkHome =
        module: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit inputs;
            settings = nixBtwSettings;
          };
          modules = [ module ];
        };

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

      # ---------------------------------
      # Home Manager
      # ---------------------------------
      homeConfigurations = {
        vijeth-nixos = mkHome ./hosts/nix-btw/home-nixos.nix system;
        vijeth-portable = mkHome ./hosts/nix-btw/home-portable.nix system;
      };
    };
}
