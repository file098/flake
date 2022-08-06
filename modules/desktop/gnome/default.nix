{ pkgs, user, ... }:

{

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome.cheese
    gnome.gnome-music
    gnome.epiphany
    gnome.gnome-weather
  ]);

  # services.gnome = { 
  #  core-utilities.enable = false;
  #  tracker-miners.enable = false;
  #  tracker.enable = false;
  # };

}
