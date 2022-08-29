# Specific system configuration settings for desktop
#

{ config, pkgs, user, ... }:

{

  imports = [
    ../../modules/desktop/gnome.nix
    ../../modules/programs/gaming.nix
    ../../modules/services/ios.nix
    ../../modules/services/samba.nix
    ../../modules/services/ssh.nix
    ../../modules/shell/npm.nix
    ./hardware-configuration.nix
  ];
  boot = { # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "libata.noacpi=1" ];
    plymouth.enable = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
        efiSupport = true;
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
    # should stop resume/suspend loop 
    extraModprobeConfig =
      "options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp";
  };

  networking = {
    wireless.networks = {
      Lumaca = {
        pskRaw =
          "784ef16e538ba594671250c8fe39ba0aaf3ccf76e500303ee53e5aa42f8c2915";
      };
    };
    hostName = "blade";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 ];
      allowedUDPPorts = [ 4000 57120 8000 8010 ];
    };
  };

  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    users = [ "${user}" ];
  };

}
