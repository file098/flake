{ pkgs, lib, user, bg-path, ... }:

let
  lock_cmd =
    "swaylock -i ${bg-path} --clock --indicator --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 000000 --fade-in 0.5";
  theme = import ../themes/theme.nix;
in {

  imports = [ ./../services/swayidle.nix ];

  # Unfortunately this must be true for GDM to work properly.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = lib.mkForce false;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    displayManager.defaultSession = lib.mkForce "sway";
  };

  systemd.services = {
    display-manager.enable = true;
    # Prevent restarting sway when using nixos-rebuild switch
    sway.restartIfChanged = false;
  };

  programs.light.enable = true;
  programs.sway.enable = true;

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

    imports = [ ./../programs/swaybar/swaybar.nix ];

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
        keybindings = let
          mod = config.modifier;
          resize_increment = "40px";
          default_increment = "5";
          left = "Left";
          down = "Down";
          up = "Up";
          right = "Right";
        in lib.mkOptionDefault {
          # Launchers
          "${mod}+t" = "exec alacritty";
          "${mod}+w" = "exec librewolf";
          "${mod}+e" = "exec pcmanfm";
          "${mod}+c" = "exec code";
          "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show=run";
          "${mod}+Print" =
            "exec ${pkgs.grim}/bin/grim  -g '$(pkgs.slurp)' /tmp/$(date +'%H:%M:%S.png')";
          "${mod}+q" = "kill";
          "${mod}+Escape" = "exec ${pkgs.swaylock}/bin/swaylock -f";

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

          "${mod}+Alt+${left}" = "resize grow width ${resize_increment}";
          "${mod}+Alt+${down}" = "resize grow height ${resize_increment}";
          "${mod}+Alt+${up}" = "resize shrink height ${resize_increment}";
          "${mod}+Alt+${right}" = "resize shrink width ${resize_increment}";

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
          # {
          #   # Auto-start all *.desktop files in auto-start directories.
          #   command = "${pkgs.dex}/bin/dex -a";
          # }
          # { command = "nm-applet --indicator"; }
          { command = "mako"; }
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

    home.packages = with pkgs; [
      alacritty
      autotiling
      bemenu # ui
      grim
      # kanshi  # display configuration # TODO: needed?
      # oguri # animated background # TODO: needed?
      slurp
      # startsway # start sway with logs going to systemd
      swaylock-effects
      swaybg # set background
      swaywsr # automatically rename workspaces with contents
      waybar
      wdisplays # display configuration
      wev
      wf-recorder # screen recorder
      wl-clipboard
      wofi
      wmfocus # window picker
      xwayland
    ];

  };
}
