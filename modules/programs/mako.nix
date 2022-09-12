{ config, ... }: {
  programs.mako = {
    enable = true;
    defaultTimeout = 5000;
    backgroundColor = "#323232";
    textColor = "#fefefe";
    borderColor = "#fefefe";
  };
}
