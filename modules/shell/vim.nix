{ inputs, ... }: {
  nixpkgs = {
    overlays = [
      (self: super:
        let
          vim-tidal = super.vimUtils.buildVimPlugin {
            name = "vim-tidal",;
            src = inputs.vim-tidal;
          };
        in { vimPlugins = super.vimPlugins // { inherit vim-tidal; }; })
    ];
  };
}
