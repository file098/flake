{ pkgs, user, ... }:

{

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      resolutions = [
        {
          x = 1920;
          y = 1080;
        }
        {
          x = 1600;
          y = 900;
        }
        {
          x = 3840;
          y = 2160;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Extentions 
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.pop-shell
    gnomeExtensions.vitals

    #Gnome packages
    pkgs.gnome3.gnome-tweaks
    gparted
    baobab
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gnome.cheese
    gnome.gnome-music
    gnome.epiphany
    gnome.gnome-weather
  ];

  # services.gnome = { 
  #  core-utilities.enable = false;
  #  tracker-miners.enable = false;
  #  tracker.enable = false;
  # };

}
