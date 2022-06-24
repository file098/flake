#
#  General Home-manager configuration
#

{ config, lib, pkgs, user, ... }:

{ 
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      pfetch            # Minimal fetch
      ranger            # File Manager
      cpufrequtils
      cryptsetup
      nmap
      # Video/Audio
      feh               # Image Viewer
      vlc               # Media Player
      # Apps
      firefox           # Browser
      # File Management
      rsync             # Syncer $ rsync -r dir1/ dir2/
      unzip             # Zip files
      unrar             # Rar files
      # General configuration
      gotop
      glxinfo
      git              # Repositories
      killall          # Stop Applications
      nano             # Text Editor
      wget             # Downloader
      zsh              # Shell
      nodejs
  
    ];
    stateVersion = "22.05";
  };

}