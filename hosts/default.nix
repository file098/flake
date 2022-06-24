{ lib, inputs, system, home-manager, user, ... }:

{
  file0 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./configuration.nix
      ./blade/hardware-configuration.nix
      ./blade/nvidia.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
            imports = [( import ./blade/home.nix)] ;
        };
      }
    ];
  };
}