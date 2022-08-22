# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [

        # Syntax
        vim-nix
        vim-markdown

        # Quality of life
        vim-lastplace # Opens document where you left it
        auto-pairs # Print double quotes/brackets/etc.
        vim-gitgutter # See uncommitted changes of file :GitGutterEnable
        vim-plug
        coc-nvim

        # File Tree
        nerdtree # File Manager - set in extraConfig to F6

        # Customization 
        tender-vim
        zenburn

        lightline-vim # Info bar at bottom
        indent-blankline-nvim # Indentation lines
      ];

      extraConfig = ''
        set nocompatible            " disable compatibility to old-time vi
        set showmatch               " show matching brackets.
        set ignorecase              " case insensitive matching
        set mouse=v                 " middle-click paste with mouse
        set hlsearch                " highlight search results
        set autoindent              " indent a new line the same amount as the line just typed
        set number                  " add line numbers
        set wildmode=longest,list   " get bash-like tab completions
        set cc=80                   " set an 80 column border for good coding style
        filetype plugin indent on   " allows auto-indenting depending on file type
        set tabstop=4               " number of columns occupied by a tab character
        set expandtab               " converts tabs to white space
        set shiftwidth=4            " width for autoindents
        set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
        syntax enable                             " Syntax highlighting
        highlight Comment cterm=italic gui=italic " Comments become italic
        colorscheme tender                        " Color scheme text          
        nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
        let g:tidal_target = "terminal"
      '';
    };
  };
}

