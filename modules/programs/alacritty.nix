{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
        settings = {
          selection.save_to_clipboard = true;
          window = {
            decorations = "none";
            opacity = 0.98;
            padding = {
              x = 15;
              y = 15;
            };
          };
        };
    }; 
  };
}