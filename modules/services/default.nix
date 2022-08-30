#  Services
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./services
#           └─ default.nix *
#               └─ ...
#

[
  ./blueman
  ./dunst.nix
  ./flameshot.nix
  ./openrazer.nix
  ./picom.nix
  ./polybar
  ./sxhkd.nix
  # ./udiskie.nix
]

# Media is pulled from desktop default config
