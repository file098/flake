{ pkgs, user, ... }:

{
  imports = [ ./desktop ./programs ./shell ];

  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      pfetch # Minimal fetch
      neofetch
      nmap
      powertop
      nodejs
      nixfmt
      zsh

      # Video/Audio
      vlc # Media Player

      # Apps
      gimp
      tdesktop

      bitwarden # password manager
      discord
      # lollypop # music player
      nicotine-plus # file sharing
      obsidian
      spotify
      whatsapp-for-linux
      transmission-gtk # torrent client

      # File
      # pcmanfm
      ranger # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip # Zip files
      unrar # Rar files
      fstl # 3D file view

    ];

    stateVersion = "22.05";
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";

        "x-scheme-handler/chrome" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
    };
  };

  programs = { exa.enable = true; };

}
