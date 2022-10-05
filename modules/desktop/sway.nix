{ config, pkgs, lib, ... }: {
  wayland.windowManager.sway = lib.mkIf enable {
    enable = true;
    systemdIntegration = true;
    extraSessionCommands = ''
      # export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export MOZ_ENABLE_WAYLAND=1
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    config = {
      # menu = "${pkgs.fuzzel}/bin/fuzzel -T ${terminal}";
      gaps.inner = 0;
      window.border = 1;
      # colors = {
      #   focused = {
      #     border = "#${colors.base05}";
      #     background = "#${colors.base0D}";
      #     text = "#${colors.base00}";
      #     indicator = "#${colors.base0D}";
      #     childBorder = "#${colors.base0D}";
      #   };
      #   focusedInactive = {
      #     border = "#${colors.base01}";
      #     background = "#${colors.base01}";
      #     text = "#${colors.base05}";
      #     indicator = "#${colors.base03}";
      #     childBorder = "#${colors.base01}";
      #   };
      #   unfocused = {
      #     border = "#${colors.base01}";
      #     background = "#${colors.base00}";
      #     text = "#${colors.base05}";
      #     indicator = "#${colors.base01}";
      #     childBorder = "#${colors.base01}";
      #   };
      #   urgent = {
      #     border = "#${colors.base08}";
      #     background = "#${colors.base08}";
      #     text = "#${colors.base00}";
      #     indicator = "#${colors.base08}";
      #     childBorder = "#${colors.base08}";
      #   };
      #   placeholder = {
      #     border = "#${colors.base00}";
      #     background = "#${colors.base00}";
      #     text = "#${colors.base05}";
      #     indicator = "#${colors.base00}";
      #     childBorder = "#${colors.base00}";
      #   };
      #   background = "#${colors.base07}";
      # };
      bars = [{ position = "top"; }];
      keybindings = let
        mod = "Mod4";
        resize_increment = "40px";
        default_increment = "5";
        left = "Left";
        down = "Down";
        up = "Up";
        right = "Right";
      in lib.mkOptionDefault {
        # for some reason home-manager doesn't bind these keys, so we bind them manually
        "${mod}+t" = "exec alacritty";
        "${mod}+w" = "exec firefox";
        "${mod}+e" = "exec pcmanfm";
        "${mod}+c" = "exec code";
        "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show=run";
        "${mod}+Print" =
          "exec ${pkgs.grim}/bin/grim  -g '$(pkgs.slurp)' /tmp/$(date +'%H:%M:%S.png')";
        "${mod}+q" = "kill";
        "${mod}+Escape" = "exec swaylock";

        # Navigation
        "${mod}+Shift+grave" = "move scratchpad";
        "${mod}+grave" = "scratchpad show";
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";
        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Ctrl+Left" = "resize grow left";
        "${mod}+Ctrl+Down" = "resize grow down";
        "${mod}+Ctrl+Up" = "resize grow up";
        "${mod}+Ctrl+Right" = "resize grow right";
        "${mod}+h" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+s" = "layout stacking";
        "${mod}+Shift+t" = "layout tabbed";
        "${mod}+Shift+g" = "sticky toggle";
        "${mod}+Shift+f" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+Alt+${left}" = "resize shrink width ${resize_increment}";
        "${mod}+Alt+${down}" = "resize grow height ${resize_increment}";
        "${mod}+Alt+${up}" = "resize shrink height ${resize_increment}";
        "${mod}+Alt+${right}" = "resize grow width ${resize_increment}";

        # Workspaces
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";
        "${mod}+Shift+r" = "reload";

        # Brightness
        "XF86MonBrightnessDown" = "exec light -U 5";
        "XF86MonBrightnessUp" = "exec light -A 5";

        # Volume
        "XF86AudioRaiseVolume" =
          "exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'";
        "XF86AudioLowerVolume" =
          "exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

      };
      input."type:pointer".accel_profile = "flat";
      output = {
        "*" = {
          # bg = "${pathToWall} fill";
        };
      };
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "LVDS-1";
        }
        {
          workspace = "2";
          output = "LVDS-1";
        }
        {
          workspace = "3";
          output = "LVDS-1";
        }
        {
          workspace = "4";
          output = "LVDS-1";
        }
        {
          workspace = "5";
          output = "LVDS-1";
        }

        {
          workspace = "6";
          output = "VGA-1";
        }
        {
          workspace = "7";
          output = "VGA-1";
        }
        {
          workspace = "8";
          output = "VGA-1";
        }
        {
          workspace = "9";
          output = "VGA-1";
        }
        {
          workspace = "10";
          output = "VGA-1";
        }
      ];
    };
  };

  systemd.user.services = {
    swaylock = {
      Unit = {
        Description = "Screen locker for Wayland";
        Documentation = "man:swaylock(1)";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaylock}/bin/swaylock";
        Restart = "on-failure";
      };
    };
  };
  services.swayidle = {
    enable = true;
    events = [{
      event = "lock";
      command = "${pkgs.systemd}/bin/systemctl start --user swaylock.service";
    }];
  };
  home.file.".swaylock/config".text = "color=000000FF";
}
