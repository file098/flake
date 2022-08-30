{ pkgs, user, ... }:

{

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.job.preStart = "sleep 5";
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    # Extentions 
    appindicator
    dash-to-dock
    tray-icons-reloaded
    sound-output-device-chooser
    pop-shell
    color-picker
    vitals
  ]) ++ (with pkgs; [
    #Gnome packages
    pkgs.gnome3.gnome-tweaks
    gparted
    baobab
  ]);

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Excluded Gnome Bloat
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [ cheese gnome-music epiphany gnome-weather ]);

  # services.gnome = { 
  #  core-utilities.enable = false;
  #  tracker-miners.enable = false;
  #  tracker.enable = false;
  # };

}
