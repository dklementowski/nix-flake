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

    devenv = {
      url = "github:cachix/devenv/v0.5.1";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, devenv }@inputs:
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
        ./modules/apps
        ./modules/audio
        ./modules/gaming
        ./modules/ops

      ];
      commonHomeManagerModules = [
        {
          nixpkgs.config.allowUnfree = true;

          nixpkgs.overlays = [
            # ( import ./overlays/tonelib.nix )
          ];
 
          home.packages = [
            devenv.packages.x86_64-linux.devenv
          ];
        }
        ./home/kitty
        ./home/shell
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
            ./modules/gnome

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                inputs.plasma-manager.homeManagerModules.plasma-manager
              ];
              home-manager.users.${vars.userName} = {
                home.stateVersion = vars.stateVersion;
                imports = commonHomeManagerModules ++ [
                  ./hosts/BigPC/home-manager
                ];
              };
            }
          ];
        };

        ThiccPad = lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [
            ./hosts/ThiccPad
            ./modules/plasma

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                inputs.plasma-manager.homeManagerModules.plasma-manager
              ];
              home-manager.users.${vars.userName} = {
                home.stateVersion = vars.stateVersion;
                imports = commonHomeManagerModules ++ [
                  ./hosts/ThiccPad/home-manager
                  ./home/plasma
                ];
              };
            }
          ];
        };
      };
    };
}
