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
        colors = {
          primary = { 
            foreground= "#bbc2cf";
            background = "#1d2021";
          };

          normal = {
            black = "#000000";
            red = "#cc6666";
            green = "#b5bd68";
            yellow = "#f0c674";
            blue = "#81a2be";
            magenta = "#b293bb";
            cyan = "#8abeb7";
            white = "#fffefe";
          };
        };
      };
    }; 
  };
}