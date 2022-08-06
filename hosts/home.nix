# general Home-manager configuration

{ pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      btop # Resource Manager
      cpufrequtils
      cryptsetup
      nmap
      pfetch # Minimal fetch
      ranger # File Manager
      feh # Image Viewer
      firefox # Browser
      rsync # Syncer $ rsync -r dir1/ dir2/
      unrar # Rar files
      unzip # Zip files
      zip
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
