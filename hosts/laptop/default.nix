{ config, pkgs, user, ... }:

{
  imports =                                 # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++   
    [(import ./nvidia.nix )] ++          # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/programs/games.nix)] ++
    [(import ../../modules/programs/virtualbox.nix)] ++
    [(import ../../modules/desktop/gnome.nix)];

  boot.kernelPackages = pkgs.linuxPackages_zen;
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

  hardware.openrazer.enable = true;

  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups = [ "networkmanager" "wheel" "openrazer" "docker" "audio" ];
  };

  environment.systemPackages = with pkgs; [
    ifuse
    libimobiledevice
    openrazer-daemon
    powertop
    python311
    python310Packages.pip 
  ];

}