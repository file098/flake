{ config, pkgs, lib, ... }:

with pkgs;
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  nixpkgs.config.allowUnfree = true;

  ############
  # Bootloader
  ############

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
      enable = true;
      version = 2;
      gfxmodeEfi = "1920x1080";
      fontSize = 32;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root F6AA-5190
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  ######################
  # Zen kernel (test me)
  ######################
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  #########
  # Network 
  #########

  networking.hostName = "blade"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 
      22
      2242
    ];
    logLevel = "VERBOSE";
  };

  services.fail2ban = {
    enable = true;
  };

  ########
  # Locale 
  ########

  # Set your time zone.
  time.timeZone = "Europe/Rome";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  hardware.keyboard.zsa.enable = true;

  #######################
  # Graphical Environment
  #######################

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome.cheese # webcam tool
    gnome.gnome-music
    gnome.epiphany # web browser
  ]);

  #services.gnome = { 
  #  core-utilities.enable = false;
  #  tracker-miners.enable = false;
  #  tracker.enable = false;
  #};
  environment.variables.EDITOR = "nvim"; 
  environment.sessionVariables = rec {
    XDG_DATA_HOME="$HOME/.local/share";
    EDITOR = "nvim";

    #PATH = [
    #  "$HOME/.npm-packages/bin:$PATH"
    #];
  };
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sound settings
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  hardware.bluetooth = {
    enable = true;
  };

  # Workaround until this hits unstable:
  # https://github.com/NixOS/nixpkgs/issues/113628
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf"
  ];

  services.blueman.enable = true;
  
  programs = {
    zsh.enable = true;
    steam.enable = true;
  };
  
  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups = [ "networkmanager" "wheel" "openrazer" "docker" "audio" ];
    shell = pkgs.zsh;
  };

  hardware.openrazer.enable = true;

  #################
  # SYSTEM PACKAGES
  #################

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    binutils
    gcc
    git
    htop
    firefox
    ifuse
    libimobiledevice
    ranger
    neofetch
    os-prober
    openrazer-daemon
    powertop
    python311
    python310Packages.pip 
    vim
    wget
    zip
    unzip
    # GNOME
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.pop-shell
    pkgs.gnome3.gnome-tweaks
    gparted
    baobab
  ];

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-emoji
    source-code-pro
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}