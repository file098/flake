# Specific packages for laptop
{ pkgs, ... }:

{
  home = {
    packages = (with pkgs; [
      # Terminal
      cbonsai
      wally-cli # planck flash tool
      youtube-dl
      light
      bluez
      blueman
      nixfmt # nix file formatter
      nodejs
      glxinfo
      vulkan-tools
      w3m # A text-mode web browser
      joshuto # Ranger-like terminal file manager written in Rust

      # Apps
      bitwarden # password manager
      discord
      fstl # 3D file view
      graphite-gtk-theme
      gnome.gnome-disk-utility
      xorg.xdpyinfo
      intel-gpu-tools
      libreoffice
      lollypop # music player
      nicotine-plus # file sharing
      obsidian
      razergenie # razer hardware support
      spotify
      thunderbird # email client
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
