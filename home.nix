{ config, pkgs, ... }:

{
  packages = with pkgs; [
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
    alacritty = {
        enable = true;
        settings = {
        selection.save_to_clipboard = true;
        window = {
            decorations = "none";
            opacity = 0.9;
            padding = {
            x = 5;
            y = 5;
            };
        };
        };
    }; 
    neovim = { 
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraConfig = "colorscheme gruvbox";
        plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox
        nerdtree
        ];
    };
    zsh = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        oh-my-zsh = {
        enable = true;
        theme = "gozilla";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" ];
        };
        shellAliases = {
        "ll" = "ls -l";
        ".." = "cd ..";
        "update" = "sudo nixos-rebuild switch";
        "edit" = "sudo nixos-rebuild edit";
        };
    };
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
