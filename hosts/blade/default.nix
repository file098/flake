{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./battery.nix
    ./nvidia.nix
    ../../modules/games.nix
    ../../services/ssh.nix
    ../../services/openrazer.nix
    ../../modules/desktop

  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "quiet" "splash" "button.lid_init_state=open" ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
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

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;

  networking.hostName = "blade";
  networking.networkmanager.enable = true;

  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups =
      [ "networkmanager" "wheel" "openrazer" "docker" "audio" "plugdev" ];
  };

  environment.systemPackages = with pkgs; [ ifuse libimobiledevice powertop ];

}
