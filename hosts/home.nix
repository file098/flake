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
      
      # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio control
      plex-media-player # Media Player
      vlc               # Media Player
      stremio           # Media Streamer

      # Apps
      firefox           # Browser
      google-chrome     # Browser
      remmina           # XRDP & VNC Client

      # File Management
      gnome.file-roller # Archive Manager
      rsync             # Syncer $ rsync -r dir1/ dir2/
      unzip             # Zip files
      unrar             # Rar files

      # General configuration
      #git              # Repositories
      #killall          # Stop Applications
      #nano             # Text Editor
      #pciutils         # Computer utility info
      #pipewire         # Sound
      #usbutils         # USB utility info
      #wacomtablet      # Wacom Tablet
      #wget             # Downloader
      #zsh              # Shell
      #
      # General home-manager
      #alacritty        # Terminal Emulator
      #dunst            # Notifications
      #doom emacs       # Text Editor
      #flameshot        # Screenshot
      #libnotify        # Dep for Dunst
      #neovim           # Text Editor
      #rofi             # Menu
      #udiskie          # Auto Mounting
      #vim              # Text Editor
      #
      # Xorg configuration
      #xclip            # Console Clipboard
      #xorg.xev         # Input viewer
      #xorg.xkill       # Kill Applications
      #xorg.xrandr      # Screen settings
      #xterm            # Terminal
      #
      # Xorg home-manager
      #picom            # Compositer
      #polybar          # Bar
      #sxhkd            # Shortcuts
      #
      # Wayland configuration
      #autotiling       # Tiling Script
      #swayidle         # Idle Management Daemon
      #wev              # Input viewer
      #wl-clipboard     # Console Clipboard
      #
      # Wayland home-manager
      #pamixer          # Pulse Audio Mixer
      #swaylock-fancy   # Screen Locker
      #waybar           # Bar
      #
      # Desktop
      #bazarr           # Subtitles
      #blueman          # Bluetooth
      #darktable        # Raw Image Processing
      #deluge           # Torrents
      #discord          # Chat
      #ffmpeg           # Video Support (dslr)
      #gmtp             # Mount MTP (GoPro)
      #gphoto2          # Digital Photography
      #handbrake        # Encoder
      #libreoffice      # Office Tools
      #lutris           # Game Launcher
      #new-lg4ff        # Logitech Drivers
      #plex             # Plex Server
      #prowlarr         # Indexer Manager
      #radarr           # Movies
      #sonarr           # TV Shows
      #steam            # Games
      #shotcut          # Video editor
      #shotwell         # Raw Image Manager
      #simple-scan      # Scanning
      # 
      # Laptop
      #blueman          # Bluetooth
      #light            # Display Brightness
      #libreoffice      # Office Tools
      #simple-scan      # Scanning
      #
      # Flatpak
      #obs-studio       # Recording/Live Streaming
    ];
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
    };                                        # Cursor is declared under home.pointerCursor
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
#     auto-cpufreq
#     afetch
#     btop
#     cpufrequtils
#     cryptsetup
#     discord
#     feh
#     gnomeExtensions.cpufreq
#     gotop
#     glxinfo
#     libreoffice
#     lollypop      
#     nmap
#     # Node  
#     nodejs
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
