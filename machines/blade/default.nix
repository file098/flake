# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, user, ... }:

{
  imports = [ ./hardware-configuration.nix ./nvidia-specialisation.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
        # useOSProber = true; # use OSProber for separate drive dual booting
        gfxmodeEfi = "1920x1080";
        # efiSupport = true;
      };
    };
    plymouth.enable = true;
  };

  networking = {
    hostName = "blade"; # Define your hostname.
    # Enable networking
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 2234 ];
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

  hardware.openrazer = {
    enable = true;
    users = [ "${user}" ];
  };

  services.cron.systemCronJobs = [
    "* * * * 0,6 rsync -ar --delete --exclude '.*' /home/file0/* sshd@192.168.1.21:/nfs/faylo98/Backups/PC/. >/dev/null 2>&1"
  ];

  services.mongodb.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  programs.steam.enable = true;

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

}
