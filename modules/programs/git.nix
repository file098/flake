{ config, pkgs, lib, ... }:
{
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "file098";
      userEmail = "filippodigennaro98@outlook.it";
      aliases = {
        st = "status";
      };
      ignores = [
        ".DS_Store"
        "*.pyc"
      ];
    };  
  };
}