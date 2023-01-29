{
  description = "System configuration for desktop use on multiple machines";

  inputs = {
    nixpkgs = {
      url = github:nixos/nixpkgs/nixpkgs-unstable;
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      vars = import ./vars.nix;
      commonModules = [
        ./modules/system
        ./modules/shell
        ./modules/desktop
        ./modules/audio
        ./modules/gaming
        ./modules/ops
      ];
      commonHomeManagerModules = [
        {
          nixpkgs.config.allowUnfree = true;

          nixpkgs.overlays = [
            ( import ./overlays/tonelib.nix )
          ];
        }
        ./home/kitty
        ./home/shell
        ./home/plasma
        ./home/protonmail
        ./home/gaming
        ./home/pro-audio
      ];
    in {
      nixosConfigurations = {
        BigPC = lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [
            ./hosts/BigPC
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                inputs.plasma-manager.homeManagerModules.plasma-manager
              ];
              home-manager.users.${vars.userName} = {
                home.stateVersion = vars.stateVersion;
                imports = commonHomeManagerModules ++ [
                  # Home Manager modules for BigPC - none for now
                ];
              };
            }
          ];
        };

        ThiccPad = lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [
            ./hosts/ThiccPad
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                inputs.plasma-manager.homeManagerModules.plasma-manager
              ];
              home-manager.users.${vars.userName} = {
                home.stateVersion = vars.stateVersion;
                imports = commonHomeManagerModules ++ [
                  # Home Manager modules for ThiccPad - none for now
                ];
              };
            }
          ];
        };
      };
    };
}
