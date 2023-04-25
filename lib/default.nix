# .dotfiles/lib/default.nix
{ self, pkgs, inputs, home-manager, system, ... }:
rec {
  user = import ./user.nix { inherit pkgs home-manager system; };
  host = import ./host.nix { inherit self pkgs inputs home-manager system; };
}
