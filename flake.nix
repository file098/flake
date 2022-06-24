{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { self, nixpkgs, home-manager }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        file0 = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
	          ./hardware-configuration.nix
            ./nvidia.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.file0 = import ./home.nix;
            }
          ];
        };  
      };
      # homeConfigurations.file0 = home-manager.lib.homeManagerConfiguration {
      #     inherit system pkgs;
      #     username = "file0";
      #     stateVersion = "22.05";
      #     homeDirectory = "/home/file0";
      #     configuration = import ./home.nix;      
      # }; 
    };
   
}
