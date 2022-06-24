#
#  Home-manager configuration for laptop
#

{ pkgs, ... }:

{
  home = {                                # Specific packages for laptop
    packages = with pkgs; [
      # Applications
      libreoffice                         # Office packages

      # Display
      #light                              # xorg.xbacklight not supported. Other option is just use xrandr.

      # Power Management
      #auto-cpufreq                       # Power management
      #tlp                                # Power management
    ];
  };

  programs = {
    alacritty.settings.font.size = 16;
  };
}
