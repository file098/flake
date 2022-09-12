{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    # ../users/file0.nix
  ];

  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "jackaudio"
      "audio"
      "sound"
      "input"
      "tty"
    ];
    shell = pkgs.zsh;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.utf8";
    LC_IDENTIFICATION = "it_IT.utf8";
    LC_MEASUREMENT = "it_IT.utf8";
    LC_MONETARY = "it_IT.utf8";
    LC_NAME = "it_IT.utf8";
    LC_NUMERIC = "it_IT.utf8";
    LC_PAPER = "it_IT.utf8";
    LC_TELEPHONE = "it_IT.utf8";
    LC_TIME = "it_IT.utf8";
  };
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "alt-intl";
  };

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
    autoUpgrade = { # Allow auto update
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}

