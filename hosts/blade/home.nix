# Specific packages for laptop
{ pkgs, ... }:

{
  imports = [
    #../../modules/desktop/bspwm/home.nix  #Window Manager
  ];
  home = {
    packages = (with pkgs; [
      bitwarden # password manager
      cbonsai
      discord
      fstl # 3D file view
      intel-gpu-tools 
      libreoffice
      librewolf
      lollypop # music player
      nicotine-plus # file sharing
      nixfmt # nix file formatter
      nodejs
      obsidian
      powertop
      razergenie # razer hardware support
      spotify
      supercollider
      tdesktop # telegram
      transmission-gtk # torrent client
      wally-cli # planck flash tool
      whatsapp-for-linux
      yarn
      youtube-dl
    ]) ++ (with pkgs.nodePackages; [
      # Node
      typescript
      webtorrent-cli
    ]);
  };
}
