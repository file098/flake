# Home-manager configuration for laptop
#
{ ... }:

{

  imports = [ (import ../../modules/programs/alacritty.nix) ]
    ++ [ (import ../../modules/programs/neovim.nix) ]
    ++ [ (import ../../modules/programs/git.nix) ]
    ++ [ (import ../../modules/programs/python.nix) ]
    ++ [ (import ../../modules/programs/zsh.nix) ];

}