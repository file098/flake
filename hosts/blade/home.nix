# home-manager configuration for laptop
#
{ config, lib, pkgs, user, ... }:

{

  imports = [ (import ../../modules/programs/alacritty.nix) ]
    ++ [ (import ../../modules/programs/neovim.nix) ]
    ++ [ (import ../../modules/programs/git.nix) ]
    ++ [ (import ../../modules/programs/python.nix) ]
    ++ [ (import ../../modules/programs/zsh.nix) ]
    # ++ [ (import ../../modules/desktop/bspwm) ]
    ;

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
