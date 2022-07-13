{ config, lib, pkgs, self, ... }:

with lib;

let
  inherit (self.lib) mkEnableDefault;
  cfg = config.blasting.desktops.gnome;
in {

  imports = [
    self.modules.desktops.common
  ];

  options.blasting.desktops.gnome = {
    enable = mkEnableDefault "Enable the GNOME desktop (gnome, gdm, apps, ...)";
    gsconnect = mkEnableDefault "Enable thee GSConnect extension";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnome.baobab
      gnome.eog
      gnome.gedit
      gnome.gnome-calculator
      gnome.gnome-screenshot
      gnome.gnome-system-monitor
      gnome.nautilus
    ]
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      espresso
      sound-output-device-chooser
    ]
    ++ optional cfg.gsconnect pkgs.gnomeExtensions.gsconnect);

    networking.firewall = mkIf cfg.gsconnect {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = false;

      gnome-online-accounts.enable = false;
      chrome-gnome-shell.enable = false;
      gnome-initial-setup.enable = false;
      gnome-remote-desktop.enable = false;
      gnome-user-share.enable = false;
      rygel.enable = false;
      sushi.enable = true;
    };
    services.packagekit.enable = false;
    services.telepathy.enable = false;

    services.udev.packages = with pkgs; [
      gnome3.gnome-settings-daemon
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      orca
    ];

    programs.evince.enable = true;
    programs.file-roller.enable = true;
    programs.gnome-disks.enable = true;
    programs.gnome-terminal.enable = true;
    programs.seahorse.enable = true;

    qt5.platformTheme = "gnome";
  };
}
