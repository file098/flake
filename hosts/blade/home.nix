# Specific packages for laptop
{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/bspwm/home.nix # Window Manager
  ];
  home = {
    packages = (with pkgs; [
      # Terminal
      cbonsai
      powertop
      wally-cli # planck flash tool
      youtube-dl
      light
      bluez
      blueman
      nixfmt # nix file formatter
      nodejs
      glxinfo
      vulkan-tools

      # Apps

      bitwarden # password manager
      discord
      fstl # 3D file view
      graphite-gtk-theme
      xorg.xdpyinfo
      intel-gpu-tools
      libreoffice
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      razergenie # razer hardware support
      spotify
      tdesktop # telegram

      whatsapp-for-linux
      transmission-gtk # torrent client
      yarn
    ]) ++ (with pkgs.nodePackages; [
      # Node
      typescript
      webtorrent-cli
    ]);
  };
}
