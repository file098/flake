{ pkgs, user, ... }:

{
  imports = [ ./desktop ./programs ./shell ];

  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      pfetch # Minimal fetch
      neofetch
      nmap
      powertop
      nodejs
      nixfmt
      sass
      python3
      gcc
      wally-cli
      # Video/Audio
      vlc # Media Player

      # Apps
      tdesktop
      firefox-wayland

      bitwarden # password manager
      discord
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      
      spotify
      spotify-tui

      whatsapp-for-linux
      transmission-gtk # torrent client

      # File
      # pcmanfm
      ranger # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip # Zip files
      unrar # Rar files
      fstl # 3D file view

      # unstable packages
      unstable.vscode
      unstable.polychromatic
      unstable.timeshift
    ];

    stateVersion = "22.05";
  };

  # xdg = {
  #   enable = true;
  #   userDirs.enable = true;
  #   mimeApps = {
  #     enable = true;
  #     defaultApplications = {
  #       "text/html" = "firefox.desktop";
  #       "x-scheme-handler/http" = "firefox.desktop";
  #       "x-scheme-handler/https" = "firefox.desktop";
  #       "x-scheme-handler/about" = "firefox.desktop";
  #       "x-scheme-handler/unknown" = "firefox.desktop";

  #       "x-scheme-handler/chrome" = "firefox.desktop";
  #       "application/x-extension-htm" = "firefox.desktop";
  #       "application/x-extension-html" = "firefox.desktop";
  #       "application/x-extension-shtml" = "firefox.desktop";
  #       "application/xhtml+xml" = "firefox.desktop";
  #       "application/x-extension-xhtml" = "firefox.desktop";
  #       "application/x-extension-xht" = "firefox.desktop";
  #     };
  #   };
  # };
}
