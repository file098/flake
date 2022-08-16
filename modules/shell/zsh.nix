{ ... }:

{

  programs = {
    zsh = {
      initExtra = "pfetch";
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" "systemd"];
      };
      shellAliases = {
        "ll" = "ls -l";
        ".." = "cd ..";
        "update" = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .#";
      };
    };
  };
}
