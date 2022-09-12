{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../users/file0
  ];
  # Set your time zone.
  time = {
    timeZone = "Europe/Rome";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_US.UTF-8";
  # console.keyMap = "us";

  # Sound settings
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  security.rtkit.enable = true;
  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true;
  };

  nixpkgs.config.allowUnfree = true; # Allow proprietary software.

  system = { # NixOS settings
    # autoUpgrade = { # Allow auto update
    #   enable = true;
    #   channel = "https://nixos.org/channels/nixos-unstable";
    # };
    stateVersion = "22.05";
  };
}

