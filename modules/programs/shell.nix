
let dotfilesDir = "$HOME/.dotfiles";
in {
  home.file.".env".source = ../../../.env;
  home.file.".zshrc".source = ../../../.zshrc;
}
