# zsh dotifles configuration
{ user, ... }:

{

  programs = {
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      initExtra = "pfetch";
      envExtra = ''
        export XDG_DATA_HOME="$HOME/.local/share"
        export LC_CTYPE=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
        export EDITOR='nvim'
        export TERMINAL='alacritty'
        export BROWSER='librewolf'
        export TERM="xterm-256color"
      '';
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" "systemd" ];
      };
      shellAliases = {
        ".." = "cd ..";
        "ls" = "exa --icons";
        "ll" = "exa -l";
        "l" = "exa -la";
        "build" =
          "sudo nixos-rebuild build --flake '/home/${user}/nixos-config#'";
        "switch" =
          "sudo nixos-rebuild switch --flake '/home/${user}/nixos-config#'";
        "config" = "ranger /home/${user}/nixos-config";
        "update" = "cd /home/${user}/nixos-config && nix flake update";
        "tidal" = "nix run github:jordanisaacs/neovim-flake#tidal file.tidal";
      };
    };
  };
}
