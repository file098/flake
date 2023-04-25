# zsh dotifles configuration
{ ... }:

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
        "update" = "nix flake update";
        "tidal" = "nix run github:jordanisaacs/neovim-flake#tidal file.tidal";
        "ng" = "npx -p @angular/cli ng";
        "sudo" = "doas";
        "switch" = "doas nixos-rebuild switch --flake .#";
     };
    };
  };
}
