# Specific packages for laptop
{ pkgs, ... }:

{
  imports = [
    #../../modules/desktop/bspwm/home.nix  #Window Manager
  ];
  home = {
    packages = (with pkgs; [
      discord
      fstl # 3D file view
      intel-gpu-tools
      libreoffice
      lollypop
      polybar
      powertop
      nixfmt # nix file formatter
      razergenie # razer hardware support
      nicotine-plus # file sharing
      obsidian
      spotify
      tdesktop # telegram
      transmission-gtk # torrent client
      wally-cli # planck flash tool
      whatsapp-for-linux
      youtube-dl
      yarn
    ]) ++ (with pkgs.nodePackages; [
      # Node
      typescript
      webtorrent-cli
    ]);
  };
}
