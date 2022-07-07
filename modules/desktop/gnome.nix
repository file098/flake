{ pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # Extentions 
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.pop-shell
    gnomeExtensions.desktop-cube
    #Gnome packages
    pkgs.gnome3.gnome-tweaks
    gparted
    baobab
  ];

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    # gnome-help
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
