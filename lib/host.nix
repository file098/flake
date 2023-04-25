{ self, pkgs, inputs, home-manager, system, ... }: {

  mkMachine = { hostName, user }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system inputs pkgs; };
      modules = [

        "${self}/machines/${hostName}"
        "${self}/nix.nix"

        user

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.file0 = import "${self}/modules";
          };
        }
        # Common shared config
        {

          networking = {
            hostName = "${hostName}";
            networkmanager.enable = true;
          };

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

          services.xserver = {
            layout = "us";
            xkbVariant = "alt-intl";
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

            printing.enable = true;
            avahi = {
              enable = true;
              openFirewall = true;
            };
          };

          hardware.keyboard.zsa.enable = true;

          system.stateVersion = "22.11";
        }
      ];
    };
}
