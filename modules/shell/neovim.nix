{ config, pkgs, ... }: {
  # home.packages = with pkgs; [
  #   fzy
  #   fd
  #   ripgrep
  #   # Add support for --remote and --servername cli-flags
  #   neovim-remote
  #   nerdfonts
  # ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    #extraConfig = builtins.readFile ./config/nvimrc;
    plugins = with pkgs; [
      vimPlugins.nerdtree
      vimPlugins.nordic-nvim
      # vimPlugins.hop-nvim
      # vimPlugins.nvim-cmp
      # vimPlugins.cmp-buffer
      # vimPlugins.cmp-nvim-lsp
      # vimPlugins.lspkind-nvim
      # vimPlugins.vim-markdown
      # vimPlugins.vim-surround
      # vimPlugins.vim-fugitive
      # vimPlugins.vim-go
      # vimPlugins.gina-vim
      # vimPlugins.emmet-vim
      # vimPlugins.vim-ni
    ];
  };
}
