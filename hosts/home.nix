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

  programs = {
    home-manager.enable = true;
  };

}

# {
#   home.stateVersion = "22.05";

#   imports = 
#     [(imports ../../modules/programs/alacritty.nix)] ++
#     [(imports ../../modules/programs/neovim.nix)] ++
#     [(imports ../../modules/programs/zsh.nix)] ++
#     [(imports ../../modules/programs/games.nix)];
  
#   home.packages = with pkgs; [
#     
#     discord
#  
#     
#     libreoffice
#     lollypop      
#     nmap
#     # Node  
#     
#     nodePackages.typescript
#     ranger
#     razergenie
#     spotify
#     vlc
#     tdesktop
#     transmission-gtk
#     vscode
#     wally-cli
#     whatsapp-for-linux
#     yapf
#     youtube-dl
#   ];

#   programs = {
#     git = {
#         enable = true;
#         userName = "file098";
#         userEmail = "filippodigennaro98@outlook.it";
#         aliases = {
#         st = "status";
#         };
#         ignores = [
#         ".DS_Store"
#         "*.pyc"
#         ];
#     };  
#   };
# }
