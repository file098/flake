{
  description = "My Personal NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  # Function that tells my flake which to use and what do what to do with the dependencies.
  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      inherit (nixpkgs) lib;

      util = import ./lib { inherit self pkgs inputs home-manager system; };
      inherit (util) host;
      inherit (util) user;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ ];
      };

      system = "x86_64-linux";
    in {

      nixosConfigurations = {
        blade = host.mkMachine {
          hostName = "blade";
          user = user.mkSystemUser {
            name = "file0";
            groups = [ "wheel" "networkmanager" "audio" "video" ];
            uid = 1000;
            shell = pkgs.zsh;
          };
        };
      };
    };
}
