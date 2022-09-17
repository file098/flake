{ self, pkgs, ... }:

{
  imports = [
    #Hardware
    ./hardware.nix

    #Graphics
    "${self}/modules/desktop/gnome.nix"
    "${self}/modules/desktop/nvidia.nix"
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
  
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
   programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako # notification daemon
      grim
     #kanshi
      slurp
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;


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
