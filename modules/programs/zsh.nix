{ pkgs, ...}:

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
        theme = "gozilla";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" ];
      };
      shellAliases = {
        "ll" = "ls -l";
        ".." = "cd ..";
        "update" = "sudo nixos-rebuild switch --flake .#file0";
        "edit" = "sudo nixos-rebuild edit";
      };
    };
  };
}
