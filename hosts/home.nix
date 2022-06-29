# General Home-manager configuration
#

{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      # Terminal
      btop # Resource Manager
      cpufrequtils
      cryptsetup
      nmap
      pfetch # Minimal fetch
      ranger # File Manager
      # Video/Audio
      vlc # Media Player
      feh # Image Viewer
      # Apps
      firefox # Browser
      # File Management
      rsync # Syncer $ rsync -r dir1/ dir2/
      unrar # Rar files
      unzip # Zip files
      zip
      # General configuration
      git # Repositories
      glxinfo
      gotop
      killall # Stop Applications
      nano # Text Editor
      nodejs
      wget # Downloader
      zsh # Shell
    ];
    stateVersion = "22.05";
  };

}
