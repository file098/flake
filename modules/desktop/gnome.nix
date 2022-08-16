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

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    # Extentions 
    appindicator
    dash-to-dock
    tray-icons-reloaded
    sound-output-device-chooser
    pop-shell
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
