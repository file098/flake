{ lib, pkgs, user, ... }:

let theme = import (dirOf <nixos-config> + /modules/theme.nix);
in {
  hardware.opengl = {
    enable = true;
    # driSupport = true; # fix crash on restart
  };

  home-manager.users."${user}" = { config, ... }:
    let
      startsway = pkgs.writeShellScriptBin "startsway" ''
        exec systemd-cat --identifier sway \
          sway --debug
      '';
    in {
      nixpkgs.overlays = [
        (_: _: { inherit startsway; })
        # (import (dirOf <nixos-config> + /modules/wayland-overlay.nix))
      ];

      wayland.windowManager.sway = rec {
        enable = true;
        config = {
          modifier = "Mod4";
          menu =
            "find ~/.nix-profile/share -name '*.desktop' | xargs basename -s .desktop | menu | xargs ${pkgs.gtk3-x11}/bin/gtk-launch";
          colors = {
            focused = {
              border = "#${theme.dark.active.background}";
              background = "#${theme.dark.active.background}";
              text = "#${theme.dark.active.foreground}";
              indicator = "#${theme.dark.active.background}";
              childBorder = "#${theme.dark.active.background}";
            };
            focusedInactive = {
              border = "#${theme.dark.active.background}";
              background = "#${theme.dark.active.background}";
              text = "#${theme.dark.active.foreground}";
              indicator = "#${theme.dark.active.background}";
              childBorder = "#${theme.dark.active.background}";
            };
            unfocused = {
              border = "#${theme.dark.inactive.background}";
              background = "#${theme.dark.inactive.background}";
              text = "#${theme.dark.inactive.foreground}";
              indicator = "#${theme.dark.inactive.background}";
              childBorder = "#${theme.dark.inactive.background}";
            };
            urgent = {
              border = "#${theme.dark.urgent.background}";
              background = "#${theme.dark.urgent.background}";
              text = "#${theme.dark.urgent.foreground}";
              indicator = "#${theme.dark.urgent.background}";
              childBorder = "#${theme.dark.urgent.background}";
            };
          };
          fonts = {
            names = [ "Ubuntu" ];
            size = 16.0;
          };
          bars = [ ];
          terminal = "foot -o colors.alpha=0.80";
          startup = [{ command = "${pkgs.autotiling}/bin/autotiling"; }];
          window = {
            titlebar = true;
            commands = let
              display = {
                width = 2560;
                height = 1600;
              };
              scratchpad = rec {
                width = display.width * 0.83;
                height = width / 1.5;
                pos_x = 0.0;
                pos_y = 0.0;
              };
            in [
              {
                criteria.app_id = "scratchpad";
                command = "floating enable";
              }
              {
                criteria.app_id = "scratchpad";
                command = "move scratchpad";
              }
              {
                criteria.app_id = "scratchpad";
                command = "scratchpad show";
              }
              {
                criteria.app_id = "scratchpad";
                command = "resize set ${toString display.width} ${
                    toString display.height
                  }";
              }
              {
                criteria.app_id = "scratchpad";
                command = "move position ${toString scratchpad.pos_x} ${
                    toString scratchpad.pos_y
                  }";
              }
            ] ++ [{
              criteria.app_id = "mpv";
              command = "inhibit_idle visible";
            }] ++ [{
              criteria.title = "Volume Control";
              command = "resize set 1000 1000";
            } # pavucontrol-qt
            ];
            border = 0;
            hideEdgeBorders = "both";
          };
          floating = {
            titlebar = true;
            criteria = [
              { window_role = "pop-up"; }
              { title = "Volume Control"; } # pavucontrol-qt
              { app_id = "imv"; }
              { app_id = "pavucontrol"; }
              { app_id = "mpv"; }
              { title = "Picture in picture"; } # Chrome PIP
              { title = "LastPass: Free Password Manager"; } # Chrome LastPass
            ];
          };
          keybindings = let
            modifier = config.modifier;
            resize_increment = "40px";
            left = "h";
            down = "j";
            up = "k";
            right = "l";
          in lib.mkOptionDefault {
            "${modifier}+Shift+c" = "kill";
            "twosuperior" = "scratchpad show";
            "${modifier}+x" = "move container to scratchpad";
            "Print" = "exec screenshot --notify copy area";

            "${modifier}+p" = "exec $menu";
            "${modifier}+q" = "reload";
            "${modifier}+i" = "exec colortemp up";
            "${modifier}+o" = "exec colortemp down";

            "${modifier}+Tab" = "focus right";
            "${modifier}+Shift+Tab" = "focus left";

            "${modifier}+t" = "layout tabbed";
            "${modifier}+s" = "layout toggle split";

            "F1" =
              "exec pamixer --toggle-mute && ( pamixer --get-mute && echo 0 > $XDG_RUNTIME_DIR/wob.sock ) || pamixer --get-volume > $XDG_RUNTIME_DIR/wob.sock";
            "F2" =
              "exec pamixer --decrease 2 && pamixer --get-volume > $XDG_RUNTIME_DIR/wob.sock";
            "F3" =
              "exec pamixer --increase 2 --allow-boost && pamixer --get-volume > $XDG_RUNTIME_DIR/wob.sock";
            "F4" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

            "Home" = "exec playerctl previous";
            "End" = "exec playerctl next";
            "F5" = ''mode "default"''; # TODO

            "${modifier}+ampersand" = "workspace 1";
            "${modifier}+eacute" = "workspace 2";
            "${modifier}+quotedbl" = "workspace 3";
            "${modifier}+apostrophe" = "workspace 4";
            "${modifier}+parenleft" = "workspace 5";
            "${modifier}+egrave" = "workspace 6";
            "${modifier}+minus" = "workspace 7";
            "${modifier}+underscore" = "workspace 8";
            "${modifier}+ccedilla" = "workspace 9";
            "${modifier}+agrave" = "workspace 10";

            "${modifier}+Shift+ampersand" = "move container to workspace 1";
            "${modifier}+Shift+eacute" = "move container to workspace 2";
            "${modifier}+Shift+quotedbl" = "move container to workspace 3";
            "${modifier}+Shift+apostrophe" = "move container to workspace 4";
            "${modifier}+Shift+parenleft" = "move container to workspace 5";
            "${modifier}+Shift+egrave" = "move container to workspace 6";
            "${modifier}+Shift+minus" = "move container to workspace 7";
            "${modifier}+Shift+underscore" = "move container to workspace 8";
            "${modifier}+Shift+ccedilla" = "move container to workspace 9";
            "${modifier}+Shift+agrave" = "move container to workspace 10";

            # "${modifier}+l" = "lock";

            "${modifier}+Alt+${left}" =
              "resize shrink width ${resize_increment}";
            "${modifier}+Alt+${down}" =
              "resize grow height ${resize_increment}";
            "${modifier}+Alt+${up}" =
              "resize shrink height ${resize_increment}";
            "${modifier}+Alt+${right}" =
              "resize grow width ${resize_increment}";
          };
          input = {
            "type:keyboard" = {
              xkb_layout = "us";
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
          output = {
            "*" = {
              scale = "1";
              background = "#000000 solid_color";
            };
          };
        };
        extraConfig = ''
          # hide titlebar on lone windows
          default_border none

          # smart_borders on

          titlebar_padding 20 8
        '';
        systemdIntegration = true;
        wrapperFeatures.gtk = true;
        wrapperFeatures.base = true;
      };

      home.packages = with pkgs; [
        alacritty
        autotiling
        bemenu # ui
        gammastep
        grim
        # kanshi  # display configuration # TODO: needed?
        # oguri # animated background # TODO: needed?
        slurp
        startsway # start sway with logs going to systemd
        sway-contrib.grimshot # screenshots
        sway-contrib.inactive-windows-transparency
        swayidle
        swaylock-effects
        swaybg # set background
        swaywsr # automatically rename workspaces with contents
        waybar
        wdisplays # display configuration
        wev
        wf-recorder # screen recorder
        wl-clipboard
        wmfocus # window picker
        xwayland
      ];
    };
}
