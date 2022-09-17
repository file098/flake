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
      glxinfo
      vulkan-tools

      # Apps
      fstl # 3D file view
      graphite-gtk-theme
      gnome.gnome-disk-utility
      intel-gpu-tools
      razergenie # razer hardware support

      yarn
    ]) ++ (with pkgs.nodePackages; [
      # Node
      typescript
      webtorrent-cli
    ]);
  };
}
