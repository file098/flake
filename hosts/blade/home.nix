{ config, pkgs, ... }:

{
  home.stateVersion = "22.05";

  imports = 
    [(imports ../../modules/programs/alacritty.nix)] ++
    [(imports ../../modules/programs/neovim.nix)] ++
    [(imports ../../modules/programs/zsh.nix)] ++
    [(imports ../../modules/programs/games.nix)];
  
  home.packages = with pkgs; [
    auto-cpufreq
    afetch
    btop
    cpufrequtils
    cryptsetup
    discord
    feh
    gnomeExtensions.cpufreq
    gotop
    glxinfo
    libreoffice
    lollypop      
    nmap
    # Node  
    nodejs
    nodePackages.typescript
    ranger
    razergenie
    spotify
    vlc
    tdesktop
    transmission-gtk
    vscode
    wally-cli
    whatsapp-for-linux
    yapf
    youtube-dl
  ];

  programs = {
    git = {
        enable = true;
        userName = "file098";
        userEmail = "filippodigennaro98@outlook.it";
        aliases = {
        st = "status";
        };
        ignores = [
        ".DS_Store"
        "*.pyc"
        ];
    };  
  };
}
