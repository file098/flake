{ config, pkgs, user, ... }:

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

  ############
  # Graphics #
  ############

  services = {
    xserver = {
      videoDrivers = [ "modesetting" ];
      enable = true;
      displayManager.gdm.wayland = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [ cheese gnome-music epiphany gnome-weather ]);
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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

  ########
  # User #
  ########

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.file0 = {
    isNormalUser = true;
    description = "Filippo";
    extraGroups = [ "networkmanager" "wheel" config.users.groups.keys.name ];
    shell = pkgs.zsh;
    packages = with pkgs; [ firefox ];
    openssh = {
      authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFDnMPTJN2fM5l9vef60ILDN2FAc68oSmV3wwZBNLrbFLpRWvw/1GadxSk2hV4jUunAhKoNfxVPZb3G59eLiRUAM3GJvZXb4pDaxisU2T04iOxMv1lml39VDFzoTNcn+tbUgB5NAHGmQJ8/RmkVvnwrS+QG/QQEOww7x2aL1mWB2E4lCGEheZ0jgFV9ra2wFulPiJGYAzwumWnjP4fHv6cTAYiH7UaJWxaRKAV6t/1qybz0Oi9h7CWfNZcNmcgWqNLDAEbxB4ovgJghTrtFkTrLSe+RtrDymJdRjptrWLD+Vfvh/ctoHGG7IBS2co26MRh9IHi9dhk921b5fmykA1vHAY/IkGuWahXkcV/AUq2J/5VVZoKAiowdCb17zDDbmfDh10xDAHUw0L4UpnGlvFCb4xBKPVZb1Y9FFuHNE7/U5Bm65kccNnlNxSxsQ0y4lytxMKdLYIBoTrq/gvJJe8shLRcpNmBfrT7tS8ilrD8v+s1IOEFyIWip7v6SD07BjGyFwkzyNzScmnYqlzgF8/uQVYUqHxxNQzprN4zjDGP/7vd8w6OZSalzKvrvZawT6ppJmYpVzYagMER4X+CiyC5UoXpgOlPg7Kl+IWcVRKCH4wEOKXr9BwrdsC4Bakzp5p7WXsVkF2cwgoLM5nd7YL9SlfVl4QUeFqAcnU0xHYxrQ== file0@blade"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-18.1.0" ];

  system.stateVersion = "22.05";

}
