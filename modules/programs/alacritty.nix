{ ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        selection.save_to_clipboard = true;
        window = {
          decorations = "none";
          gtk_theme_variant = "None";
          opacity = 0.98;
          padding = {
            x = 15;
            y = 15;
          };
        };
        font.size = 10;
        colors = {
          primary = {
            foreground = "#bbc2cf";
            background = "#202020";
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
