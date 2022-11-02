# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, user, nixos-hardware, ... }:

{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-gpu-intel
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        useOSProber = true; # use OSProber for separate drive dual booting
        gfxmodeEfi = "1920x1080";
        efiSupport = true;
      };
    };
  };

  networking.hostName = "blade"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;

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
      enable = true;
      # displayManager.gdm.wayland = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "alt-intl";
  };

  specialisation = {
    nvidia-gpu.configuration = {
      system.nixos.tags = [ "nvidia-gpu" ];
      # imports = [ nixos-hardware.nixosModules.common-gpu-nvidia ];
      hardware.nvidia.package =
        config.boot.kernelPackages.nvidiaPackages.stable;
      services.xserver.videoDrivers = [ "nvidia" ];
      environment.systemPackages = with pkgs; [ nvtop glmark2 ];
    };
  };

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    # Extentions 
    appindicator
    dash-to-dock
    tray-icons-reloaded
    sound-output-device-chooser
    pop-shell
  ]) ++ (with pkgs; [
    #Gnome packages
    pkgs.gnome3.gnome-tweaks
    gnome.gnome-power-manager
    gparted
    baobab

    glxinfo
    intel-gpu-tools
    intel-media-driver

    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
    shotwell
  ]);

  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [ cheese gnome-music epiphany gnome-weather ]);

  #############################################################S

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "${user}" ];

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
    # passwordFile = config.sops.secrets.my-password.path;
  };

  programs.steam.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.05"; # Did you read the comment?

}
