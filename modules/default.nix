{ pkgs, user, ... }:

{
  imports = [ ./desktop ./programs ./shell ];

  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # list of packages managed by HM
      gimp
      neofetch
      nixfmt
      pfetch
      obsidian
    ];

    stateVersion = "22.05";
  };

  programs = { exa.enable = true; };

}
