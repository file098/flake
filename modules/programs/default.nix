# Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./apps
#           └─ default.nix *
#               └─ ...
#
{

  imports = [ ./alacritty.nix ./neovim.nix ./mako.nix ];

}

