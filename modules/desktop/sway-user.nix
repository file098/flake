{ pkgs, lib, user, bg-path, ... }: {
  # Unfortunately this must be true for GDM to work properly.
  services.xserver.enable = true;

  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  systemd.services.display-manager.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.defaultSession = lib.mkForce "sway";
  services.xserver.videoDrivers = lib.mkForce [ ];

  # Prevent restarting sway when using nixos-rebuild switch
  systemd.services.sway.restartIfChanged = false;

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      alacritty
      wl-clipboard
      mako
      foot
      wofi
      swaylock
      swaylock-effects
      swayidle
      bemenu # wayland clone of dmenu
    ];
    extraSessionCommands = ''
      # Source: https://github.com/cole-mickens/nixcfg/blob/707b2db0a5f69ffda027f8008835f01d03954dcb/mixins/nvidia.nix#L7-L13
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export WLR_NO_HARDWARE_CURSORS=1

      # Source: https://gist.github.com/zimbatm/b82817b7feb5b58a8003d6afced62065#file-sway-nix-L56-L69
      # SDL:
      export SDL_VIDEODRIVER=wayland
      # QT (needs qt5.qtwayland in systemPackages):
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    #gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
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
        input = { "*" = { tap = "enabled"; }; };
        bars = [{
          command = "waybar";
          position = "top";
        }];
        menu = "bemenu-run";
        keybindings = let mod = config.modifier;
        in {
          "${mod}+t" = "exec alacritty";
          "${mod}+w" = "exec librewolf";
          "${mod}+e" = "exec pcmanfm";
          "${mod}+d" = "exec ${pkgs.bemenu}/bin/bemenu-run";
          "${mod}+Delete" = "exec loginctl lock-session";
          "${mod}+Print" = "exec flameshot gui";
          "${mod}+q" = "kill";
          "${mod}+Escape" = "exec swaylock -i ${bg-path} ";

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
          "${mod}+Shift+e" = ''
            exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';

          "XF86AudioRaiseVolume" =
            "exec ${pkgs.pamixer}/bin/pamixer --increase 5";
          "XF86AudioLowerVolume" =
            "exec ${pkgs.pamixer}/bin/pamixer --decrease 5";
          "XF86AudioMute" = "exec ${pkgs.pamixer} --toggle-mute";

          "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
          "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";

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
          {
            command = "mako";
          }
          # { command = "nm-applet --indicator"; }
        ];
      };
      extraConfig = ''
        workspace_layout default
        default_orientation auto
        gaps inner 10
        gaps outer 4
        smart_gaps on
        default_border pixel 3
      '';
    };

    programs.swaylock.settings = { image = "${bg-path}"; };

    services.swayidle = {
      enable = true;
      timeouts = [{
        timeout = 5 * 60;
        command = "swaylock -f";
      }];
      events = [
        {
          event = "before-sleep";
          command = "swaylock -i ${bg-path}";
        }
        {
          event = "lock";
          command = "swaylock -f";
        }
      ];
    };

    programs.waybar = {
      enable = true;
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
          modules-center = [ ];
          modules-right = [ "network" "battery" "clock" "tray" ];
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
  };
}
