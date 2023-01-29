# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, user, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/nvme0n1";
      useOSProber = true; # use OSProber for separate drive dual booting
      gfxmodeEfi = "1920x1080";
    };
    plymouth.enable = true;
  };

  networking.hostName = "blade"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 2234  ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
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

  ###################
  # System Packages #
  ###################

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    # Extentions 
    appindicator
    dash-to-dock
    tray-icons-reloaded
    pop-shell
    color-picker
    caffeine
  ]) ++ (with pkgs; [
    #Gnome packages
    pkgs.gnome3.gnome-tweaks
    gnome.gnome-power-manager
    gparted
    baobab

    glxinfo
    intel-gpu-tools
    intel-media-driver
    nvtop

    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
    shotwell
  ]);

  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.mongodb.enable = true;

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [ cheese gnome-music epiphany gnome-weather ]);

  #############################################################

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "${user}" ];

  hardware.keyboard.zsa.enable = true;

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

  services.usbmuxd.enable = true;

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    #permitRootLogin = "yes";
  };

  services.cron.systemCronJobs = [
    "* * * * 0,6 rsync -ar --delete --exclude '.*' /home/file0/* wdmycloud:/nfs/faylo98/Backups/PC/. >/dev/null 2>&1"
  ];

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  ##################
  # Virtualization #
  ##################

  virtualisation.virtualbox.host = { 
    enable = true;
    enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "file0" ];

  ################
  # Battery life #
  ################

  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;

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

  system.stateVersion = "22.05"; # Did you read the comment?

}
