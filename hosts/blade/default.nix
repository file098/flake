#
#  Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./vm
#   │       ├─ default.nix *
#   │       └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./bspwm
#               └─ bspwm.nix
#

{ config, pkgs, ... }:

{
  imports =  [                                  # For now, if applying to other system, swap files
    ./hardware-configuration.nix  
    ../../modules/desktop/gnome.nix
    # ../../modules/desktop/bspwm/bspwm.nix        # Window Manager
  ];

  boot = {                                      # Boot options
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {            
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        enable = true;
        version = 2;
        device = "nodev";
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root FCFC-D67F
            chainloader /EFI/Microsoft/Boot/bootmgfw.edi
          }
        '';
      };
    };
  };

  networking.hostName = "blade";
  networking.networkmanager.enable = true;

  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    devicesOffOnScreensaver = false;
  };

  services = {
    xserver = {                                 
      resolutions = [
        { x = 1920; y = 1080; }
        { x = 1600; y = 900; }
        { x = 3840; y = 2160; }
      ];
    };
  };
}
