{ pkgs, ...}:

{
  programs = {
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
  };
}
