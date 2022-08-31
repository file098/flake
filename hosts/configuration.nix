# Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix *
#   └─ ./modules
#       └─ ./editors
#           └─ ./emacs
#               └─ default.nix
#

{ config, lib, pkgs, inputs, user, ... }:

{

  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    description = "Filippo";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "plugdev" "video" ];
    shell = pkgs.zsh;
  };

  # Set your time zone.
  time = {
    timeZone = "Europe/Rome";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_US.utf8";

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

  fonts.fonts = with pkgs; [ # Fonts
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    (nerdfonts.override { # Nerdfont Icons override
      fonts = [ "FiraCode" ];
    })
  ];

  environment = {
    sessionVariables = rec {
      XDG_DATA_HOME = "$HOME/.local/share";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL="en_US.UTF-8";
    };
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [ # Default packages install system-wide
      curl
      vim
      git
      killall
      nano
      neofetch
      neovim
      pciutils
      usbutils
      wget
    ];
  };

  nix = { # Nix Package Manager settings
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = { # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes; # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
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

