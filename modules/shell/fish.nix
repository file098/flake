{ user, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ## Rust rewrites
      #   cat = "echo FATAL: Use bat"; # https://github.com/sharkdp/bat
      #   find = "echo FATAL: Use fd"; # https://github.com/sharkdp/fd
      #   sed = "echo FATAL: Use sd"; # https://github.com/chmln/sd
      #   grep = "echo FATAL: Use rg"; # https://github.com/BurntSushi/ripgrep
      #   ps = "echo FATAL: Use procs"; # https://github.com/dalance/procs
      #   top = "echo FATAL: Use btm"; # https://github.com/ClementTsang/bottom
      #   regexgen = "echo FATAL: Use grex"; # https://github.com/pemistahl/grex

      # tldr       -> tealdeer, but bin is still tldr      @ https://github.com/dbrgn/tealdeer
      # Worth mentioning:
      # - cd       -> zoxide                               @ https://github.com/ajeetdsouza/zoxide
      # - hyperfine                                        @ https://github.com/sharkdp/hyperfine
      # - tokei                                            @ https://github.com/XAMPPRocky/tokei
      # - bandwhich                                        @ https://github.com/imsnif/bandwhich
      # - nushell                                          @ https://github.com/nushell/nushell
      # - starship                                         @ https://github.com/starship/starship
      # - dust                                             @ https://github.com/bootandy/dust

      l = "exa -la --icons"; # https://github.com/ogham/exa
      ls = "exa --icons";
      sl = "exa --icons";
      ll = "ls -l";
      ".." = "cd ..";
      build = "sudo nixos-rebuild build --flake '/home/${user}/nixos-config#'";
      switch =
        "sudo nixos-rebuild switch --flake '/home/${user}/nixos-config#'";
      config = "ranger /home/${user}/nixos-config";
      update = "cd /home/${user}/nixos-config && nix flake update";
    };

    shellInit = ''
      fish_add_path "$HOME/.local/bin" # pip
      fish_add_path "$HOME/.npm_global/bin" # npm
      fish_add_path "$HOME/.yarn/bin" # yarn

    '';

  };
}
