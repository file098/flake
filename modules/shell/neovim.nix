{ config, pkgs, ... }:

let trackedPlugins = pkgs.packages;
in {
  home.packages = with pkgs; [
    fzy
    fd
    ripgrep
    # Add support for --remote and --servername cli-flags
    neovim-remote
    nerdfonts
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    #extraConfig = builtins.readFile ./config/nvimrc;
    plugins = with pkgs; [
      {
        plugin = pkgs.vimPlugins.gruvbox;
        #     #NOTE prepand my nvimrc to first plugin config, as extraConfig seems
        #     #to be added after plugin configs instead of before. Resulting in
        #     #broken keymaps etc.
        #     config = builtins.readFile ./config/nvimrc
        #       + builtins.readFile ./config/gruvbox.vim;
      }
      #   {
      #     plugin = pkgs.vimPlugins.nvim-lspconfig;
      #     config = builtins.readFile ./config/lspconfig.vim;
      #   }
      vimPlugins.nerdtree
      vimPlugins.hop-nvim
      vimPlugins.nvim-cmp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-nvim-lsp
      vimPlugins.lspkind-nvim
      #   {
      #     plugin = pkgs.vimPlugins.lspsaga-nvim;
      #     config = builtins.readFile ./config/lspsaga.vim;
      #   }
      vimPlugins.vim-surround
      vimPlugins.vim-fugitive
      vimPlugins.vim-go
      vimPlugins.gina-vim
      vimPlugins.emmet-vim
      vimPlugins.vim-nix
      #   {
      #     plugin = trackedPlugins.vim-rescript;
      #     config = builtins.readFile ./config/vim-rescript.vim;
      #   }
      #   {
      #     plugin = trackedPlugins.vim-picker;
      #     config = builtins.readFile ./config/vim-picker.vim;
      #   }
      #   {
      #     plugin = pkgs.vimPlugins.editorconfig-vim;
      #     config = builtins.readFile ./config/editorconfig.vim;
      #   }
      #   {
      #     plugin = trackedPlugins.vim-baker;
      #     config = builtins.readFile ./config/baker.vim;
      #   }
      #   {
      #     plugin = pkgs.vimPlugins.vimwiki;
      #     config = builtins.readFile ./config/vimwiki.vim;
      #   }
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.telescope-fzy-native-nvim
      #{
      #  plugin = hardmode;
      #  #config = builtins.readFile ./config/hardmode.vim
      #}
      #trackedPlugins.Ada-Bundle
    ];
  };
}
