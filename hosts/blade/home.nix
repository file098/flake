# Home-manager configuration for laptop
#
{ config, lib, pkgs, user, ... }:

{

  imports = [ (import ../../modules/programs/alacritty.nix) ]
    ++ [ (import ../../modules/programs/neovim.nix) ]
    ++ [ (import ../../modules/programs/git.nix) ]
    ++ [ (import ../../modules/programs/zsh.nix) ];

  home.packages = with pkgs; [
    # Node
    nodePackages.typescript
    nodePackages.webtorrent-cli
    yarn

    discord
    fstl # 3D file view
    nixfmt # nix file formatter
    libreoffice
    lollypop
    razergenie # razer hardware support
    soulseekqt # file sharing
    spotify
    tdesktop # telegram
    transmission-gtk # torrent client
    vscode
    wally-cli # planck flash tool
    whatsapp-for-linux
    youtube-dl
  ];

  programs = { alacritty.settings.font.size = 14; };
}
