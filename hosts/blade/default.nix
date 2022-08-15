# Specific system configuration settings for desktop
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
  imports = [ # For now, if applying to other system, swap files
    ./hardware-configuration.nix
    ../../modules/desktop/gnome.nix
    #../../modules/desktop/bspwm/bspwm.nix        # Window Manager
  ];

  boot = { # Boot options
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
        gfxmodeEfi = "1920x1080";
        font = "${pkgs.grub2}/share/grub/unicode.pf2";
        fontSize = 32;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root FCFC-D67F
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
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

}
