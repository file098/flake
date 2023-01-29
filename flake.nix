{

  description = "My Personal NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "unstable";
    };

    customPkgs = {
      url = "path:./overlays/vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  # Function that tells my flake which to use and what do what to do with the dependencies.
  outputs = inputs@{ self, nixpkgs, unstable, home-manager, customPkgs
    , nixos-hardware, ... }:

    let
      user = "file0";
      system = "x86_64-linux";
    in {

      nixosConfigurations = {
        blade = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nix.nix
            ./machines/blade
            
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-gpu-intel
            # this allows the use of unstable packages in the HM modules
            ({ ... }: {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import unstable {
                    system = prev.system;
                    config.allowUnfree = true;
                  };
                })
              ];
            })

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit user unstable; };
              home-manager.users."${user}" = import "${self}/modules";
            }
          ];
          specialArgs = { inherit inputs user; };
        };
      };
    };

}
