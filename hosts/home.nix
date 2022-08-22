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
  imports = 
  (import ../modules/programs) ++
  (import ../modules/services) ++
  (import ../modules/shell);

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

      # Video/Audio
      feh # Image Viewer
      pavucontrol # Audio control
      vlc # Media Player
      mpv

      # Apps
      firefox # Browser
      vscode

      # File Management
      ranger # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip # Zip files
      unrar # Rar files

    ];
    # file.".config/wall".source = ../modules/themes/wall;
    # pointerCursor =
    #   { # This will set cursor systemwide so applications can not choose their own
    #     name = "Dracula-cursors";
    #     package = pkgs.dracula-theme;
    #     size = 16;
    #   };
    stateVersion = "22.05";
  };

  programs = { home-manager.enable = true; };

  # gtk = { # Theming
  #   enable = true;
  #   theme = {
  #     name = "graphite";
  #     package = pkgs.graphite-gtk-theme;    
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   font = {
  #     name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
  #   };                                        # Cursor is declared under home.pointerCursor
  # };
}
