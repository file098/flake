# General Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix *
#   └─ ./modules
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       └─ ./shell
#           └─ default.nix
#

{ config, lib, pkgs, user, ... }:

{
  # Home Manager Modules
  imports = [ 
    ./programs 
    ./services
    ./shell 
    ./desktop/sway
  ];

  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      # Terminal
      btop # Resource Manager
      htop
      pfetch # Minimal fetch
      neofetch
      nmap
      zsh
      exa
      powertop
      nixfmt
      nodejs
      nixfmt
      git

      # Video/Audio
      feh # Image Viewer
      pavucontrol # Audio control
      vlc # Media Player

      # Apps
      librewolf
      firefox
      vscode
      tdesktop

      bitwarden # password manager
      discord
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      spotify
      whatsapp-for-linux
      transmission-gtk # torrent client

      # File Management
      pcmanfm
      ranger # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip # Zip files
      unrar # Rar files
      fstl # 3D file view

    ];

    stateVersion = "22.05";
  };

}
