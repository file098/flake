{ config, pkgs, ... }:

{
  imports = [
    ../../desktop/gnome.nix
    ../../services/ssh.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "tower"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  environment.systemPackages = with pkgs; [ vscode ];

  system.stateVersion = "22.05";

}
