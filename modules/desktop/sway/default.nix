# { pkgs, user, ... }: {
#   imports = [
#     ./sway.nix
#     ./swayidle.nix 
#     ./swaylock.nix
#     ./swaybar/swaybar.nix
#   ];

#   home.packages = with pkgs; [
#     autotiling
#     dracula-theme # gtk theme
#     glib # gsettings
#     gnome3.adwaita-icon-theme # default gnome cursors
#     grim # screenshot functionality
#     slurp # screenshot functionality
#     swaybg # set background
#     swaylock-effects
#     swaywsr # automatically rename workspaces with contents
#     # waybar
#     wayland
#     wdisplays # display configuration
#     wev
#     wf-recorder # screen recorder
#     wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
#     wmfocus # window picker
#     wofi
#     xwayland
#   ];

#   home.sessionVariables = {
#     MOZ_ENABLE_WAYLAND = true;
#     QT_QPA_PLATFORM = "wayland";
#     LIBSEAT_BACKEND = "logind";
#   };
# }
