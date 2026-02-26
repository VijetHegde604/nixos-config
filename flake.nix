{
  description = "Vijet's unified NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

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
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      # GLOBAL OVERLAY FIX
      overlay = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (python-final: python-prev: {
            picosvg = python-prev.picosvg.overridePythonAttrs (_: {
              doCheck = false;
            });
          })
        ];
      };

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ];
        };

      mkHome =
        module: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = { inherit inputs; };
          modules = [ module ];
        };

    in
    {
      # -------------------------
      # NixOS configuration
      # -------------------------
      nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          (
            { ... }:
            {
              nixpkgs.overlays = [ overlay ];
            }
          )

          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # ---------------------------------
      # Home Manager
      # ---------------------------------
      homeConfigurations = {
        vijeth-nixos = mkHome ./home-nixos.nix system;
        vijeth-portable = mkHome ./home-portable.nix system;
      };
    };
}
