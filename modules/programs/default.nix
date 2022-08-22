#  Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./apps
#           └─ default.nix *
#               └─ ...
#

[
  ./alacritty.nix
  # ./rofi.nix
  ./rbw.nix
]
# Steam.nix is pulled from desktop/default.nix
# Waybar.nix is pulled from laptop/home.nix
