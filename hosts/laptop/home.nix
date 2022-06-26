#
#  Home-manager configuration for laptop
#
{ config, lib, pkgs, user, ... }:

{

  imports = 
    [(import ../../modules/programs/alacritty.nix)] ++
    [(import ../../modules/programs/neovim.nix)] ++
    [(import ../../modules/programs/git.nix)] ++
    [(import ../../modules/programs/zsh.nix)];
    
  home.packages = with pkgs; [
    # Node
    nodePackages.typescript
    yarn
    
    discord
    libreoffice
    lollypop          
    razergenie
    soulseekqt
    spotify
    tdesktop
    transmission-gtk
    vscode
    wally-cli
    whatsapp-for-linux
    yapf
    youtube-dl
  ];

  programs = {
    alacritty.settings.font.size = 14;
  };
}
