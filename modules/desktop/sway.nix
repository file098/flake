{ pkgs, lib, user, bg-path, ... }:

let
  lock_cmd =
    "swaylock -i ${bg-path} --clock --indicator --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 000000 --fade-in 0.5";
  theme = import  ../themes/theme.nix;
in {
  # Unfortunately this must be true for GDM to work properly.
  services.xserver.enable = true;

  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  systemd.services.display-manager.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.defaultSession = lib.mkForce "sway";
  #services.xserver.videoDrivers = lib.mkForce [ ];

  # Prevent restarting sway when using nixos-rebuild switch
  systemd.services.sway.restartIfChanged = false;

  programs.light.enable = true;

  programs.sway = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    #gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
  };

  environment.sessionVariables = {
    # fixes cursor disappearing issues in VMs
    WLR_NO_HARDWARE_CURSORS = "1";
    # control qt theme with qt5ct
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # fixes gtk theme not applying to certain apps (maybe its gtk4 apps? evince/seahorse)
    GTK_THEME = "Adwaita:dark";
  };

  home-manager.users."${user}" = {
    services.dunst.enable = lib.mkForce false;
    services.network-manager-applet.enable = lib.mkForce false;
    xsession.enable = lib.mkForce false;
    xsession.windowManager.i3.enable = lib.mkForce false;

    wayland.windowManager.sway = rec {
      enable = true;
      systemdIntegration = true;
      xwayland = true;
      config = {
        modifier = "Mod4";
        output = { "*" = { bg = "${bg-path} fill"; }; };
        input = {
          "*" = {
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
        bars = [{
          command = "waybar";
          position = "top";
        }];
        menu = "bemenu-run";
        terminal = "alacritty";
        window.titlebar = true;
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
        keybindings = let mod = config.modifier;
        in {
          # Launchers
          "${mod}+t" = "exec alacritty";
          "${mod}+w" = "exec librewolf";
          "${mod}+e" = "exec pcmanfm";
          "${mod}+c" = "exec code";
          "${mod}+d" = "exec ${pkgs.bemenu}/bin/bemenu-run";
          "${mod}+Delete" = "exec loginctl lock-session";
          "${mod}+Print" = "exec flameshot gui";
          "${mod}+q" = "kill";
          "${mod}+Escape" = "exec swaylock -i ${bg-path} ";

          # Navigation
          "${mod}+Shift+grave" = "move scratchpad";
          "${mod}+grave" = "scratchpad show";
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+semicolon" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
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
        startup = [
          {
            # Auto-start all *.desktop files in auto-start directories.
            command = "${pkgs.dex}/bin/dex -a";
          }
          # { command = "${pkgs.waybar}/bin/waybar"; }
          { command = "mako"; }
          { command = "nm-applet --indicator"; }
        ];
      };
      extraConfig = ''
        workspace_layout default
        default_orientation auto
        gaps inner 10
        gaps outer 4
        # smart_gaps on
        default_border pixel 2

        workspace 1 output eDP-1
        workspace 10 output DP-3
      '';
    };

    programs.swaylock.settings = { image = "${bg-path}"; };

    services.swayidle = {
      enable = true;
      timeouts = [{
        timeout = 5 * 60;
        command = lock_cmd;
      }];
      events = [
        {
          event = "before-sleep";
          command = lock_cmd;
        }
        {
          event = "lock";
          command = lock_cmd;
        }
      ];
    };

    programs.waybar = {
      enable = true;
      # systemd = {
      #   enable = true;
      #   target = "sway-session.target";
      # };
      style = let
        # base16-default-dark-css = pkgs.fetchurl {
        #   url = "https://raw.githubusercontent.com/mnussbaum/base16-waybar/d2f943b1abb9c9f295e4c6760b7bdfc2125171d2/colors/base16-default-dark.css";
        #   hash = "sha256:1dncxqgf7zsk39bbvrlnh89lsgr2fnvq5l50xvmpnibk764bz0jb";
        # };
        style = pkgs.fetchurl {
          url =
            "https://raw.githubusercontent.com/robertjk/dotfiles/253b86442dae4d07d872e8b963fa33b5f8819594/.config/waybar/style.css";
          hash = "sha256-7bEOPMslgpXsKOa2aMqVoV5z1OSSRqXs2UGDgWwejx4=";
        };
      in ''
        @import "${style}";
      '';
      settings = {
        mainBar = {
          position = "top";
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "clock" ];
          modules-right = [ "network" "pulseaudio" "battery" "tray" ];
          "sway/window" = { max-length = 50; };
          # network = {
          #   format = "";
          #   format-wired = "";
          #   format-linked = "";
          #   format-wifi = "{essid} {icon}";
          #   format-disconnected = "";
          #   tooltip-format = ''
          #     {ifname}
          #     {ipaddr}
          #     {essid} ({signalStrength}%)'';
          # };
          network = {
            format = "{icon} {essid}";
            format-alt = "{ipaddr}/{cidr} {icon}";
            format-alt-click = "click-right";
            format-icons = {
              wifi = [ "" "" "" ];
              ethernet = [ "" ];
              disconnected = [ "" ];
            };
            on-click = "alacritty -e 'nmtui'";
            tooltip = false;
          };
          pulseaudio = {
            format = "{icon} {volume:2}%";
            format-bluetooth = "{icon}  {volume}%";
            format-muted = "MUTE";
            format-icons = {
              headphones = "";
              default = [ "" "" ];
            };
            scroll-step = 5;
            on-click = "pamixer -t";
            on-click-right = "pavucontrol";
          };
          battery = {
            format = "{capacity}% {icon}";
            format-icons = [ "" "" "" "" "" ];
          };
          clock = { format-alt = "{:%a, %d. %b  %H:%M}"; };
        };
      };
    };

    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        key-bindings = { search-start = "Control+Shift+f"; };
        search-bindings = {
          find-next = "Control+f";
          find-prev = "Control+Shift+f";
          cursor-right = "none";
        };
      };
    };

    programs.mako.enable = true;

    home.packages = with pkgs; [
        alacritty
        autotiling
        bemenu # ui
        grim
        # kanshi  # display configuration # TODO: needed?
        # oguri # animated background # TODO: needed?
        slurp
        # startsway # start sway with logs going to systemd
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
