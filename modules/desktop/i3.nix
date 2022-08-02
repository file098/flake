
{ config, pkgs, callPackage, ... }: 
{
  services.xserver = {
    enable = true;   
    desktopManager = {
      default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
  };
}