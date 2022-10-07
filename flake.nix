{

  description = "My Personal NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    customPkgs = {
      url = "path:./overlays/vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Function that tells my flake which to use and what do what to do with the dependencies.
  outputs = inputs@{ self, nixpkgs, unstable, home-manager, customPkgs, ... }:

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
