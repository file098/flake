{ pkgs, ...}:

{  
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.pop-shell
    pkgs.gnome3.gnome-tweaks
    gparted
    baobab
  ];


  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome.cheese # webcam tool
    gnome.gnome-music
    gnome.epiphany # web browser
  ]);

  #services.gnome = { 
  #  core-utilities.enable = false;
  #  tracker-miners.enable = false;
  #  tracker.enable = false;
  #};
}