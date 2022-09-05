{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        margin-left = 2;
        margin-right = 2;
        spacing = 0;
        modules-left = [
          "sway/workspaces"
          "custom/separator"
          "custom/launcher"
          "custom/separator"
          "tray"
          "sway/window"

        ];
        modules-center = [ "wlr/taskbar" ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "backlight"
          "custom/separator"
          "battery"
          "clock"
        ];
        # Modules configuration
        "sway/window" = { max-length = 50; };
        "wlr/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
        "wlr/taskbar" = {
          all-outputs = false;
          format = "{icon}";
          icon-size = 20;
          icon-theme = "Nordzy";
          tooltip = true;
          tooltip-format = "{icon} {app_id}";
          on-click = "minimize-raise";
        };
        tray = {
          icon-size = 20;
          spacing = 15;
          smooth-scolling-threshold = 1.0;
          show-passve-icons = true;
        };
        clock = {
          timezone = "Europe/Rome";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            {calendar}'';
          calendar-weeks-pos = "left";
          format-calendar = "<b>{}</b>";
          format-calendar-weeks = "<span>Week: <i>{}</i></span>";
          format = " {:%H:%M  %Y-%m-%d}";
        };
        cpu = {
          format = " {usage}%";
          tooltip = true;
          tooltip-format = ''
            {load}
            {usage}
            {avg_frequency}GHz'';
        };
        memory = {
          format = " {percentage}%";
          tooltip = true;
          tooltip-format = ''
            Used: {used}GiB/{total}GiB
            Available: {avail}GiB'';
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        battery = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ " " " " " " " " ];
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {essid}";
          tooltip-format = ''
            SSID: {essid}
            Interface: {ifname} via {gwaddr}
            IP: {ipaddr}
            Subnetmask: {netmask}-{cidr}
            Connection Strength: {signalStrength}%
            Frequency: {frequency}GHz
            Up Speed: {bandwidthUpBits}
            Down Speed: {bandwidthDownBits}'';
          format-linked = "{ifname} (No IP)";
          format-disconnected = "(No Internet)";
          on-click = "alacritty -e nmtui";
        };
        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "M {format_source}";
          format-source = " {volume}%";
          format-source-muted = "M";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "alacritty -e pavucontrol";
          tooltip = true;
          tooltip-format = ''
            {icon} {desc}
            Volume: {volume}
            {format_source}'';
        };
        "custom/launcher" = {
          format = "";
          on-click = "wofi --show=run";
          max-length = 50;
          tooltip = false;
          tooltip-format = " wofi ";
        };
        "custom/separator" = {
          format = "|";
          tooltip = false;
        };
      };
    };
    style = ./style.scss;

  };
}
