{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    nixgl = {                                                             #OpenGL 
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixgl }:
    let 
      system = "x86_64-linux";
      user = "file0";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in 
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;            # Also inherit home-manager so it does not need to be defined here.
        }
      );
      # homeConfigurations.file0 = home-manager.lib.homeManagerConfiguration {
      #     inherit system pkgs;
      #     username = "file0";
      #     stateVersion = "22.05";
      #     homeDirectory = "/home/file0";
      #     configuration = import ./home.nix;      
      # }; 
    };
   
}
