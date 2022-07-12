{ config, pkgs, user, ... }:

{
  imports = # For now, if applying to other system, swap files
    [ (import ./hardware-configuration.nix) ] ++ [ (import ./nvidia.nix) ]
    ++ [ (import ../../modules/programs/games.nix) ]
    ++ [ (import ../../services/ssh.nix) ]
    ++ [ (import ../../modules/desktop/gnome.nix) ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "quiet" "splash" "button.lid_init_state=open" ];
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
          search --fs-uuid --set=root FCFC-D67F
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  networking.hostName = "blade";
  networking.networkmanager.enable = true;

  hardware.openrazer.enable = true;

  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups =
      [ "networkmanager" "wheel" "openrazer" "docker" "audio" "plugdev" ];
  };

  environment.systemPackages = with pkgs; [
    ifuse
    libimobiledevice
    openrazer-daemon
    polychromatic
    powertop
  ];

}
