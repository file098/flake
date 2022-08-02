# home-manager configuration for laptop
#
{ config, lib, pkgs, user, ... }:

{

  imports = [
    ../../modules/programs/alacritty.nix
    ../../modules/programs/neovim.nix
    ../../modules/programs/git.nix
    ../../modules/programs/python.nix
    ../../modules/programs/zsh.nix
    ../../modules/desk-env/bspwm/home.nix
    ../../modules/desk-env/sxhkd/home.nix
    ../../modules/programs/rofi.nix
    ../../modules/programs/picom.nix
    ../../modules/programs/feh.nix
  ];

  home.packages = with pkgs; [
    # Node
    nodePackages.typescript
    nodePackages.webtorrent-cli
    yarn

    brave
    discord
    fstl # 3D file view
    libreoffice
    lollypop
    polybar
    nixfmt # nix file formatter
    razergenie # razer hardware support
    nicotine-plus # file sharing
    spotify
    tdesktop # telegram
    transmission-gtk # torrent client
    vlc # media player
    vscode
    wally-cli # planck flash tool
    whatsapp-for-linux
    youtube-dl
  ];

  programs = { alacritty.settings.font.size = 14; };
}
