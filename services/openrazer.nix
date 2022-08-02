{ pkgs, ... }:
 {
  environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    devicesOffOnScreensaver = false;
  };
}
