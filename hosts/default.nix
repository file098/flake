#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       ├─ home.nix
#       └─ ./desktop OR ./laptop OR ./vm
#            ├─ ./default.nix
#            └─ ./home.nix 
#

{ lib, inputs, nixpkgs, home-manager, nur, user, location, ... }:

let
  system = "x86_64-linux";                             	    # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  tower = lib.nixosSystem {                               # Desktop profile
    inherit system;
    specialArgs = { inherit inputs user location; };        # Pass flake variable
    modules = [                                             # Modules that are used.
      nur.nixosModules.nur
      ./tower
      ./configuration.nix
      home-manager.nixosModules.home-manager {              # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./tower/home.nix)];
        };
      }
    ];
  };

  blade = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./blade
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./blade/home.nix)];
        };
      }
    ];
  };

}
