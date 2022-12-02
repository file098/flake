{
  description = "Vim plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

    # Plugins
    "hop-nvim" = {
      type = "github";
      owner = "phaazon";
      repo = "hop.nvim";
      flake = false;
    };
    "nvim-lspkind" = {
      type = "github";
      owner = "onsails";
      repo = "lspkind-nvim";
      flake = false;
    };
    "nvim-cmp" = {
      type = "github";
      owner = "hrsh7th";
      repo = "nvim-cmp";
      flake = false;
    };
    "cmp-nvim-lsp" = {
      type = "github";
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      flake = false;
    };
    "cmp-buffer" = {
      type = "github";
      owner = "hrsh7th";
      repo = "cmp-buffer";
      flake = false;
    };
    "gina.vim" = {
      type = "github";
      owner = "lambdalisue";
      repo = "gina.vim";
      flake = false;
    };
    "vim-fzy" = {
      type = "github";
      owner = "bfrg";
      repo = "vim-fzy";
      flake = false;
    };
    "vim-picker" = {
      type = "github";
      owner = "srstevenson";
      repo = "vim-picker";
      flake = false;
    };
    "vim-rescript" = {
      type = "github";
      owner = "rescript-lang";
      repo = "vim-rescript";
      flake = false;
    };
    "asyncomplete-lsp.vim" = {
      type = "github";
      owner = "prabirshrestha";
      repo = "asyncomplete-lsp.vim";
      flake = false;
    };
    "asyncomplete.vim" = {
      type = "github";
      owner = "prabirshrestha";
      repo = "asyncomplete.vim";
      flake = false;
    };
    "vim-lsp" = {
      type = "github";
      owner = "prabirshrestha";
      repo = "vim-lsp";
      flake = false;
    };
    "Ada-Bundle" = {
      type = "github";
      owner = "vim-scripts";
      repo = "Ada-Bundle";
      flake = false;
    };
    "emmet-vim" = {
      type = "github";
      owner = "mattn";
      repo = "emmet-vim";
      flake = false;
    };
    "gruvbox" = {
      type = "github";
      owner = "morhetz";
      repo = "gruvbox";
      flake = false;
    };
    "hardmode" = {
      type = "github";
      owner = "wikitopian";
      repo = "hardmode";
      flake = false;
    };
    "literate.vim" = {
      type = "github";
      owner = "zyedidia";
      repo = "literate.vim";
      flake = false;
    };
    "vim-baker" = {
      type = "github";
      owner = "GlancingMind";
      repo = "vim-baker";
      flake = false;
    };
    "vim-editorconfig" = {
      type = "github";
      owner = "sgur";
      repo = "vim-editorconfig";
      flake = false;
    };
    "vim-erlang-omnicomplete" = {
      type = "github";
      owner = "vim-erlang";
      repo = "vim-erlang-omnicomplete";
      flake = false;
    };
    "vim-erlang-runtime" = {
      type = "github";
      owner = "vim-erlang";
      repo = "vim-erlang-runtime";
      flake = false;
    };
    "vim-fugitive" = {
      type = "github";
      owner = "tpope";
      repo = "vim-fugitive";
      flake = false;
    };
    "vim-nix" = {
      type = "github";
      owner = "LnL7";
      repo = "vim-nix";
      flake = false;
    };
    "vim-surround" = {
      type = "github";
      owner = "tpope";
      repo = "vim-surround";
      flake = false;
    };
    "vimwiki" = {
      type = "github";
      owner = "vimwiki";
      repo = "vimwiki";
      flake = false;
    };
  };

  outputs = pluginSources@{ self, nixpkgs, ... }: {
    packages."x86_64-linux" = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      buildPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
      plugins = builtins.mapAttrs (name: src:
        buildPlugin {
          pname = name;
          inherit name;
          inherit src;
        }) pluginSources;
    in plugins;

    overlay = final: prev: self.packages."x86_64-linux";
  };
}
