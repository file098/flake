{ pkgs, ... }:
{
  imports = [ ./programs ./shell ./coding ];

  programs.home-manager.enable = true;

  services.caffeine.enable = true;

  home = {
    username = "file0";
    homeDirectory = "/home/file0";

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
      nordic
      zathura

      # Video/Audio
      vlc # Media Player
      spotify
      kdenlive

      # Apps
      tdesktop
      firefox-wayland
      timeshift

      bitwarden # password manager
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      discord
      protonvpn-gui

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

      polychromatic

      # Development
      vscode
      # mongodb-compass
      # mongosh
      postman
      node2nix
    ];

    stateVersion = "22.11";
  };

}
