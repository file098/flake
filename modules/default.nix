{ pkgs, user, unstable, ... }:

{
  imports = [ ./programs ./shell ];

  programs.home-manager.enable = true;

  services.caffeine.enable = true;

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
      cordless
      wally-cli
      caffeine-ng

      # Video/Audio
      vlc # Media Player
      shotcut
      spotify

      # Apps
      tdesktop
      firefox-wayland
      timeshift

      wine
      # winetricks (all versions)
      winetricks
      # native wayland support (unstable)
      #wineWowPackages.waylandFull

      bitwarden # password manager
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      discord

      spotify-tui

      razergenie

      whatsapp-for-linux
      transmission-gtk # torrent client

      # File
      # pcmanfm
      ranger # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip # Zip files
      unrar # Rar files
      fstl # 3D file view

      vscode
      polychromatic
      mongodb-compass
      mongosh
    ];

    stateVersion = "22.05";
  };

}
