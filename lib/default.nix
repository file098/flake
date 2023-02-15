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
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit user; };
            users."${user}" = import "${self}/modules";
          };
        }

        # Common shared config
        {
          # Set your time zone.
          time.timeZone = "Europe/Rome";

          # Select internationalisation properties.
          i18n.defaultLocale = "en_US.utf8";

          i18n.extraLocaleSettings = {
            LC_ADDRESS = "it_IT.utf8";
            LC_IDENTIFICATION = "it_IT.utf8";
            LC_MEASUREMENT = "it_IT.utf8";
            LC_MONETARY = "it_IT.utf8";
            LC_NAME = "it_IT.utf8";
            LC_NUMERIC = "it_IT.utf8";
            LC_PAPER = "it_IT.utf8";
            LC_TELEPHONE = "it_IT.utf8";
            LC_TIME = "it_IT.utf8";
          };

          # Configure console keymap
          console.keyMap = "us";

          #########
          # Sound #
          #########

          # Enable sound with pipewire.
          sound.enable = true;
          hardware.pulseaudio.enable = false;
          security.rtkit.enable = true;
          services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            jack.enable = true;
          };

          ############
          # Services #
          ############

          services = {
            usbmuxd.enable = true;

            openssh = {
              enable = true;
              # require public key authentication for better security
              passwordAuthentication = false;
              kbdInteractiveAuthentication = false;
              #permitRootLogin = "yes";
            };

            printing.enable = true;
            avahi = {
              enable = true;
              openFirewall = true;
            };
          };

          hardware.keyboard.zsa.enable = true;

          system.stateVersion = "22.05";
        }
      ];
    };
}
