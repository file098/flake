{ pkgs, ... }:

{
  imports = [
    # ../../modules/desktop/bspwm/home.nix  #Window Manager
  ];

  home = { # Specific packages for laptop
    packages = with pkgs; [
      # Node
      nodePackages.typescript
      nodePackages.webtorrent-cli
      yarn

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
  };
}
