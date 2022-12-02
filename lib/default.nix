{ self, pkgs, inputs, home-manager, system, ... }: {

  mkMachine = { userName, hostName }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system inputs pkgs; };
      modules = [

        # TODO: for each folder in machines get the default config for each machine
        "${self}/machines/${hostName}"

        "${self}/nix.nix"

        # TODO: maybe the creation of the home manager default config should be handled by another custom function
        #Home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user; };
          home-manager.users."${user}" = import "${self}/modules";
        }

        {
          networking.hostName = "${hostName}";

          users.users.file0 = {
            isNormalUser = true;
            description = "Filippo";
            extraGroups = [ "networkmanager" "wheel" ];
            # packages = with pkgs; [ ];
          };

          system.stateVersion = "22.05";
        }
      ];
    };
}
