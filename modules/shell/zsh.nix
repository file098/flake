{ user, ... }:

{

  programs = {
    zsh = {
      initExtra = "pfetch";
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      envExtra = ''
        export XDG_DATA_HOME="$HOME/.local/share"
        export LC_CTYPE=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
      '';
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = [ "sudo" "git" "npm" "ng" "web-search" "systemd"];
      };
      shellAliases = {
        ".." = "cd ..";
        "build" = "sudo nixos-rebuild build --flake '/home/${user}/nixos-config#'";
        "switch" = "sudo nixos-rebuild switch --flake '/home/${user}/nixos-config#'";
        "config" = "ranger /home/${user}/nixos-config";
        "update" = "cd /home/${user}/nixos-config && nix flake update";
      };
    };
  };
}
