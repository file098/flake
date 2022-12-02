{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "file098";
    userEmail = "filippodigennaro98@outlook.it";
  };
}
