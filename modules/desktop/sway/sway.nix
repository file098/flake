# { pkgs, lib, user, ... }:

# {
#   services.dunst.enable = lib.mkForce false;
#   services.network-manager-applet.enable = lib.mkForce false;
#   xsession.enable = lib.mkForce false;
#   xsession.windowManager.i3.enable = lib.mkForce false;

#   wayland.windowManager.sway = rec {
#     enable = true;
#     wrapperFeatures.gtk = true;
#     # systemdIntegration = true;
#     # extraOptions = [ "--unsupported-gpu" ];
#     # xwayland = true;
#     config = {
#       modifier = "Mod4";
#       output = {
#         # "*" = { bg = "${bg-path} fill"; };
#         eDP-1 = { res = "1920x1080@144hz"; };
#         DP-3 = { res = "1920x1080@75hz"; };
#       };
#       input = {
#         "*" = {
#           xkb_layout = "us";
#           # xkb_options = "intl";
#           xkb_variant = "intl";
#         };
#         "type:touchpad" = {
#           dwt = "enabled";
#           tap = "enabled";
#           natural_scroll = "enabled";
#           middle_emulation = "enabled";
#         };
#       };
#       bars = [{
#         command = "waybar";
#         position = "top";
#       }];
#       menu = "wofi";
#       terminal = "alacritty";
#       window.titlebar = true;
#       keybindings = let
#         mod = config.modifier;
#         resize_increment = "40px";
#         default_increment = "5";
#         left = "Left";
#         down = "Down";
#         up = "Up";
#         right = "Right";
#       in lib.mkOptionDefault {
#         # Launchers
#         "${mod}+t" = "exec alacritty";
#         "${mod}+w" = "exec librewolf";
#         "${mod}+e" = "exec pcmanfm";
#         "${mod}+c" = "exec code";
#         "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show=run";
#         "${mod}+Print" =
#           "exec ${pkgs.grim}/bin/grim  -g '$(pkgs.slurp)' /tmp/$(date +'%H:%M:%S.png')";
#         "${mod}+q" = "kill";
#         "${mod}+Escape" = "exec swaylock";

#         # Navigation
#         "${mod}+Shift+grave" = "move scratchpad";
#         "${mod}+grave" = "scratchpad show";
#         "${mod}+j" = "focus left";
#         "${mod}+k" = "focus down";
#         "${mod}+l" = "focus up";
#         "${mod}+semicolon" = "focus right";
#         "${mod}+${left}" = "focus left";
#         "${mod}+${down}" = "focus down";
#         "${mod}+${up}" = "focus up";
#         "${mod}+${right}" = "focus right";
#         "${mod}+Shift+j" = "move left";
#         "${mod}+Shift+k" = "move down";
#         "${mod}+Shift+l" = "move up";
#         "${mod}+Shift+semicolon" = "move right";
#         "${mod}+Shift+Left" = "move left";
#         "${mod}+Shift+Down" = "move down";
#         "${mod}+Shift+Up" = "move up";
#         "${mod}+Shift+Right" = "move right";
#         "${mod}+Ctrl+Left" = "resize grow left";
#         "${mod}+Ctrl+Down" = "resize grow down";
#         "${mod}+Ctrl+Up" = "resize grow up";
#         "${mod}+Ctrl+Right" = "resize grow right";
#         "${mod}+h" = "split h";
#         "${mod}+v" = "split v";
#         "${mod}+f" = "fullscreen";
#         "${mod}+Shift+s" = "layout stacking";
#         "${mod}+Shift+t" = "layout tabbed";
#         "${mod}+Shift+g" = "sticky toggle";
#         "${mod}+Shift+f" = "floating toggle";
#         "${mod}+space" = "focus mode_toggle";

#         "${mod}+Alt+${left}" = "resize shrink width ${resize_increment}";
#         "${mod}+Alt+${down}" = "resize grow height ${resize_increment}";
#         "${mod}+Alt+${up}" = "resize shrink height ${resize_increment}";
#         "${mod}+Alt+${right}" = "resize grow width ${resize_increment}";

#         # Workspaces
#         "${mod}+1" = "workspace 1";
#         "${mod}+2" = "workspace 2";
#         "${mod}+3" = "workspace 3";
#         "${mod}+4" = "workspace 4";
#         "${mod}+5" = "workspace 5";
#         "${mod}+6" = "workspace 6";
#         "${mod}+7" = "workspace 7";
#         "${mod}+8" = "workspace 8";
#         "${mod}+9" = "workspace 9";
#         "${mod}+0" = "workspace 10";
#         "${mod}+Shift+1" = "move container to workspace 1";
#         "${mod}+Shift+2" = "move container to workspace 2";
#         "${mod}+Shift+3" = "move container to workspace 3";
#         "${mod}+Shift+4" = "move container to workspace 4";
#         "${mod}+Shift+5" = "move container to workspace 5";
#         "${mod}+Shift+6" = "move container to workspace 6";
#         "${mod}+Shift+7" = "move container to workspace 7";
#         "${mod}+Shift+8" = "move container to workspace 8";
#         "${mod}+Shift+9" = "move container to workspace 9";
#         "${mod}+Shift+0" = "move container to workspace 10";
#         "${mod}+Shift+r" = "reload";

#         # Brightness
#         "XF86MonBrightnessDown" = "exec light -U 5";
#         "XF86MonBrightnessUp" = "exec light -A 5";

#         # Volume
#         "XF86AudioRaiseVolume" =
#           "exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'";
#         "XF86AudioLowerVolume" =
#           "exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'";
#         "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";

#         "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
#         "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
#         "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
#         "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

#       };
#       startup = [{ command = "mako"; }];
#     };
#     extraConfig = ''
#       workspace_layout default
#       default_orientation auto
#       gaps inner 10
#       gaps outer 4
#       # smart_gaps on
#       default_border pixel 2

#       workspace 1 output eDP-1
#       workspace 2 output DP-3
#     '';
#   };

#   # programs.foot = {
#   #   enable = true;
#   #   server.enable = true;
#   #   settings = {
#   #     key-bindings = { search-start = "Control+Shift+f"; };
#   #     search-bindings = {
#   #       find-next = "Control+f";
#   #       find-prev = "Control+Shift+f";
#   #       cursor-right = "none";
#   #     };
#   #   };
#   # };

# }
