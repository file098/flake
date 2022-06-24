{ pkgs, ... }:

{
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
  };
}