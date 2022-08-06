# home-manager configuration for laptop
#
{ config, lib, pkgs, user, ... }:

{

  imports = [
    ../../modules/desktop/bspwm
    ../../modules/desktop/sxhkd
    ../../programs/alacritty.nix
    ../../programs/feh.nix
    #../../programs/firefox.nix
    ../../programs/git.nix
    ../../programs/neovim.nix
    ../../programs/picom.nix
    ../../programs/python.nix
    ../../programs/rofi.nix
    ../../programs/zsh.nix
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
