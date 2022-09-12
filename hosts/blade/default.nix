{ pkgs, ... }:

{
  imports = [
    #Hardware
    ./hardware.nix
    ../../modules/desktop/gnome.nix
    ../../modules/desktop/nvidia.nix
  ];

  boot = { # Boot options
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

  networking = {
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
  };
}
