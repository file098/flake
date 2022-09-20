{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    # ../users/file0.nix
  ];

  environment.defaultPackages = with pkgs; [ nerdfonts ];

  users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups = [
      "wheel"
      "networkmanager"
      # "plugdev"
      "video"
      "openrazer"
      # "jackaudio"
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
  console.keyMap = "us";

  # Sound settings
  # sound.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  #   extraConfig = ''
  #     load-module module-switch-on-connect
  #   '';
  # };

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [{ "device.name" = "~bluez_card.*"; }];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          # Matches all sources
          {
            "node.name" = "~bluez_input.*";
          }
          # Matches all outputs
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = { "node.pause-on-idle" = false; };
      }
    ];
  };

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;

  # ios support 
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
    shotwell
    pulseaudio
    bluez
  ];

  nixpkgs.config.allowUnfree = true; # Allow proprietary software.

  system = { # NixOS settings
    # autoUpgrade = { # Allow auto update
    #   enable = true;
    #   channel = "https://nixos.org/channels/nixos-unstable";
    # };
    stateVersion = "22.05";
  };
}

