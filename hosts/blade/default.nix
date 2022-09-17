{ self, pkgs, ... }:

{
  imports = [
    #Hardware
    ./hardware.nix

    #Graphics
    "${self}/modules/desktop/gnome.nix"
    "${self}/modules/desktop/nvidia.nix"
    "${self}/modules/desktop/sway.nix"

  ];

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
        useOSProber = true; # use OSProber for separate drive dual booting
        gfxmodeEfi = "1920x1080";
        efiSupport = true;

        splashImage = "${self}/other/wallpapers/mountain.png";
        font =
          "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/'Sauce Code Pro Nerd Font Complete.ttf'";
        fontSize = 28;
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

  hardware = {
    openrazer = {
      enable = true;
      keyStatistics = true;
    };
    # bluetooth.enable = true;
    keyboard.zsa.enable = true;
  };
}
