{ lib, inputs, nixpkgs, nixpkgs-unstable, system, home-manager, user, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
  lib-unstable = nixpkgs-unstable.lib;
in {
  blade = lib-unstable.nixosSystem { # blade profile
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./blade
      ./base-configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./blade/home.nix) ];
        };
      }
    ];
  };
  tower = lib.nixosSystem { # server profile
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [ 
      ./tower
      ./base-configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./tower/home.nix) ];
        };
      }
    ];
  };
}
