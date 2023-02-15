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
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" "systemd" "vscode" "z" ];
      };
      shellAliases = {
        ".." = "cd ..";
        # "ls" = "exa --icons";
        # "ll" = "exa -l";
        # "l" = "exa -la";
        "build" =
          "sudo nixos-rebuild build --flake '/home/${user}/nixos-config#'";
        "switch" =
          "sudo nixos-rebuild switch --flake '/home/${user}/nixos-config#'";
        "config" = "ranger /home/${user}/nixos-config";
        "update" = "nix flake update";
        "tidal" = "nix run github:jordanisaacs/neovim-flake#tidal file.tidal";
        "ng" = "npx -p @angular/cli ng";
        "sudo" = "doas";
      };
    };
  };
}
