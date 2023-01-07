{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      vars = import ./vars.nix;
      mkSystem = pkgs: hostname:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            { networking.hostName = hostname; }

            ./modules/system
            ./modules/shell
            ./modules/audio
            ./modules/desktop
            ./modules/gaming
            ./modules/ops
            ./configuration.nix
            ./hosts/${hostname}

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = false;
              home-manager.users.${vars.userName} = {
                imports = [
                  ./home.nix
                ];
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        BigPC = mkSystem inputs.nixpkgs "BigPC";
        ThinkPad = mkSystem inputs.nixpkgs "ThinkPad";
      };
    };
}
