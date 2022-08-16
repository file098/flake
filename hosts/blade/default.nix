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

{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/gnome.nix
    ../../modules/services/ios.nix
    ../../modules/programs/gaming/default.nix
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
        font =
          "${pkgs.grub2}/share/grub/unicode.pf2"; # "${pkgs.iosevka}/share/fonts/truetype/iosevka-medium.ttf";
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

  networking = {
    hostName = "blade";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };

  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    users = [ "${user}" ];
  };

}
