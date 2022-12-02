# { config, pkgs, lib, ... }: {
#   wayland.windowManager.sway = lib.mkIf enable {
#     enable = true;
#     systemdIntegration = true;
#     extraSessionCommands = ''
#       # export SDL_VIDEODRIVER=wayland
#       # needs qt5.qtwayland in systemPackages
#       export QT_QPA_PLATFORM=wayland
#       export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
#       export MOZ_ENABLE_WAYLAND=1
#       # Fix for some Java AWT applications (e.g. Android Studio),
#       # use this if they aren't displayed properly:
#       export _JAVA_AWT_WM_NONREPARENTING=1
#     '';
#     wrapperFeatures = {
#       gtk = true;
#       base = true;
#     };
#     config = {
#       # menu = "${pkgs.fuzzel}/bin/fuzzel -T ${terminal}";
#       gaps.inner = 0;
#       window.border = 1;
#       # colors = {
#       #   focused = {
#       #     border = "#${colors.base05}";
#       #     background = "#${colors.base0D}";
#       #     text = "#${colors.base00}";
#       #     indicator = "#${colors.base0D}";
#       #     childBorder = "#${colors.base0D}";
#       #   };
#       #   focusedInactive = {
#       #     border = "#${colors.base01}";
#       #     background = "#${colors.base01}";
#       #     text = "#${colors.base05}";
#       #     indicator = "#${colors.base03}";
#       #     childBorder = "#${colors.base01}";
#       #   };
#       #   unfocused = {
#       #     border = "#${colors.base01}";
#       #     background = "#${colors.base00}";
#       #     text = "#${colors.base05}";
#       #     indicator = "#${colors.base01}";
#       #     childBorder = "#${colors.base01}";
#       #   };
#       #   urgent = {
#       #     border = "#${colors.base08}";
#       #     background = "#${colors.base08}";
#       #     text = "#${colors.base00}";
#       #     indicator = "#${colors.base08}";
#       #     childBorder = "#${colors.base08}";
#       #   };
#       #   placeholder = {
#       #     border = "#${colors.base00}";
#       #     background = "#${colors.base00}";
#       #     text = "#${colors.base05}";
#       #     indicator = "#${colors.base00}";
#       #     childBorder = "#${colors.base00}";
#       #   };
#       #   background = "#${colors.base07}";
#       # };
#       bars = [{ position = "top"; }];
#       keybindings = let
#         modifier = "Mod4";
#         resize_increment = "40px";
#         default_increment = "5";
#         left = "Left";
#         down = "Down";
#         up = "Up";
#         right = "Right";
#       in lib.mkOptionDefault {
#         # for some reason home-manager doesn't bind these keys, so we bind them manually
#         "${modifier}+t" = "exec alacritty";
#         "${modifier}+w" = "exec firefox";
#         "${modifier}+e" = "exec pcmanfm";
#         "${modifier}+c" = "exec code";
#         "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show=run";
#         "${modifier}+Print" =
#           "exec ${pkgs.grim}/bin/grim  -g '$(pkgs.slurp)' /tmp/$(date +'%H:%M:%S.png')";
#         "${modifier}+q" = "kill";
#         "${modifier}+Escape" = "exec swaylock";

#         # Navigation
#         "${modifier}+Shift+grave" = "move scratchpad";
#         "${modifier}+grave" = "scratchpad show";
#         "${modifier}+j" = "focus left";
#         "${modifier}+k" = "focus down";
#         "${modifier}+l" = "focus up";
#         "${modifier}+semicolon" = "focus right";
#         "${modifier}+${left}" = "focus left";
#         "${modifier}+${down}" = "focus down";
#         "${modifier}+${up}" = "focus up";
#         "${modifier}+${right}" = "focus right";
#         "${modifier}+Shift+j" = "move left";
#         "${modifier}+Shift+k" = "move down";
#         "${modifier}+Shift+l" = "move up";
#         "${modifier}+Shift+semicolon" = "move right";
#         "${modifier}+Shift+Left" = "move left";
#         "${modifier}+Shift+Down" = "move down";
#         "${modifier}+Shift+Up" = "move up";
#         "${modifier}+Shift+Right" = "move right";
#         "${modifier}+Ctrl+Left" = "resize grow left";
#         "${modifier}+Ctrl+Down" = "resize grow down";
#         "${modifier}+Ctrl+Up" = "resize grow up";
#         "${modifier}+Ctrl+Right" = "resize grow right";
#         "${modifier}+h" = "split h";
#         "${modifier}+v" = "split v";
#         "${modifier}+f" = "fullscreen";
#         "${modifier}+Shift+s" = "layout stacking";
#         "${modifier}+Shift+t" = "layout tabbed";
#         "${modifier}+Shift+g" = "sticky toggle";
#         "${modifier}+Shift+f" = "floating toggle";
#         "${modifier}+space" = "focus mode_toggle";

#         "${modifier}+Alt+${left}" = "resize shrink width ${resize_increment}";
#         "${modifier}+Alt+${down}" = "resize grow height ${resize_increment}";
#         "${modifier}+Alt+${up}" = "resize shrink height ${resize_increment}";
#         "${modifier}+Alt+${right}" = "resize grow width ${resize_increment}";

#         # Workspaces
#         "${modifier}+1" = "workspace 1";
#         "${modifier}+2" = "workspace 2";
#         "${modifier}+3" = "workspace 3";
#         "${modifier}+4" = "workspace 4";
#         "${modifier}+5" = "workspace 5";
#         "${modifier}+6" = "workspace 6";
#         "${modifier}+7" = "workspace 7";
#         "${modifier}+8" = "workspace 8";
#         "${modifier}+9" = "workspace 9";
#         "${modifier}+0" = "workspace 10";
#         "${modifier}+Shift+1" = "move container to workspace 1";
#         "${modifier}+Shift+2" = "move container to workspace 2";
#         "${modifier}+Shift+3" = "move container to workspace 3";
#         "${modifier}+Shift+4" = "move container to workspace 4";
#         "${modifier}+Shift+5" = "move container to workspace 5";
#         "${modifier}+Shift+6" = "move container to workspace 6";
#         "${modifier}+Shift+7" = "move container to workspace 7";
#         "${modifier}+Shift+8" = "move container to workspace 8";
#         "${modifier}+Shift+9" = "move container to workspace 9";
#         "${modifier}+Shift+0" = "move container to workspace 10";
#         "${modifier}+Shift+r" = "reload";

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
#       input."type:pointer".accel_profile = "flat";
#       output = {
#         "*" = {
#           # bg = "${pathToWall} fill";
#         };
#       };
#       workspaceOutputAssign = [
#         {
#           workspace = "1";
#           output = "LVDS-1";
#         }
#         {
#           workspace = "2";
#           output = "LVDS-1";
#         }
#         {
#           workspace = "3";
#           output = "LVDS-1";
#         }
#         {
#           workspace = "4";
#           output = "LVDS-1";
#         }
#         {
#           workspace = "5";
#           output = "LVDS-1";
#         }

#         {
#           workspace = "6";
#           output = "VGA-1";
#         }
#         {
#           workspace = "7";
#           output = "VGA-1";
#         }
#         {
#           workspace = "8";
#           output = "VGA-1";
#         }
#         {
#           workspace = "9";
#           output = "VGA-1";
#         }
#         {
#           workspace = "10";
#           output = "VGA-1";
#         }
#       ];
#     };
#   };

#   systemd.user.services = {
#     swaylock = {
#       Unit = {
#         Description = "Screen locker for Wayland";
#         Documentation = "man:swaylock(1)";
#       };
#       Service = {
#         Type = "simple";
#         ExecStart = "${pkgs.swaylock}/bin/swaylock";
#         Restart = "on-failure";
#       };
#     };
#   };
#   services.swayidle = {
#     enable = true;
#     events = [{
#       event = "lock";
#       command = "${pkgs.systemd}/bin/systemctl start --user swaylock.service";
#     }];
#   };
#   home.file.".swaylock/config".text = "color=000000FF";
# }

{ config, lib, pkgs, ... }:
let
  glenda-wallpaper = builtins.fetchurl {
    url = "https://9p.io/plan9/img/spaceglenda300.jpg";
    sha256 = "1d16z1ralcvif6clyn244w08wypbvag1hrwi68jbdpv24x0r2vfg";
  };
in {
  #nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bemenu
    grim
    slurp
    swappy
    qt5.qtwayland
    source-code-pro
    # pulseaudio # required to use pactl for media keys
    # firefox-wayland
    wdisplays
  ];

  # fonts.fontconfig.enable = true;

  # xdg.configFile."i3status".source = ../../program/status/i3status;

  home.sessionVariables = {
    TERM = "alacritty";
    BROWSER = "firefox";

    # enable wayland support for firefox
    MOZ_ENABLE_WAYLAND = "1";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland;xcb"; # if wayland doesn't work fall back to x
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd_hrgb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  wayland.windowManager.sway = rec {
    enable = true;
    xwayland = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "BEMENU_BACKEND=wayland ${pkgs.bemenu}/bin/bemenu-run -m 1 -i";
      output = { "*" = { bg = "${glenda-wallpaper} fit #ffffff"; }; };
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variants = "intl";
          xkb_options = "intl";
        };
        "type:pointer" = {
          accel_profile = "adaptive";
          pointer_accel = "0.8";
        };
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      keybindings = let
        modifier = config.modifier;
        resize_increment = "40px";
        left = "Left";
        down = "Down";
        up = "Up";
        right = "Right";
      in lib.mkOptionDefault {
        "${modifier}+t" = "exec alacritty";
        "${modifier}+w" = "exec firefox";
        "${modifier}+e" = "exec pcmanfm";
        "${modifier}+c" = "exec code";
        "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show=run";
        "${modifier}+Print" =
          "exec ${pkgs.grim}/bin/grim  -g '$(pkgs.slurp)' /tmp/$(date +'%H:%M:%S.png')";
        "${modifier}+q" = "kill";
        "${modifier}+Escape" = "exec swaylock";

        # Navigation
        "${modifier}+Shift+grave" = "move scratchpad";
        "${modifier}+grave" = "scratchpad show";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Ctrl+Left" = "resize grow left";
        "${modifier}+Ctrl+Down" = "resize grow down";
        "${modifier}+Ctrl+Up" = "resize grow up";
        "${modifier}+Ctrl+Right" = "resize grow right";
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+f" = "fullscreen";
        "${modifier}+Shift+s" = "layout stacking";
        "${modifier}+Shift+t" = "layout tabbed";
        "${modifier}+Shift+g" = "sticky toggle";
        "${modifier}+Shift+f" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+Alt+${left}" = "resize shrink width ${resize_increment}";
        "${modifier}+Alt+${down}" = "resize grow height ${resize_increment}";
        "${modifier}+Alt+${up}" = "resize shrink height ${resize_increment}";
        "${modifier}+Alt+${right}" = "resize grow width ${resize_increment}";

        # Workspaces
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";
        "${modifier}+Shift+r" = "reload";
        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" =
          "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessUp" =
          "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
        "XF86MonBrightnessDown" =
          " exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
      };
    };
  };

  # systemd.user.services = {
  #   swaylock = {
  #     Unit = {
  #       Description = "Screen locker for Wayland";
  #       Documentation = "man:swaylock(1)";
  #     };
  #     Service = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.swaylock}/bin/swaylock";
  #       Restart = "on-failure";
  #     };
  #   };
  # };
  # services.swayidle = {
  #   enable = true;
  #   events = [{
  #     event = "lock";
  #     command = "${pkgs.systemd}/bin/systemctl start --user swaylock.service";
  #   }];
  # };
  # home.file.".swaylock/config".text = "color=000000FF";
}

