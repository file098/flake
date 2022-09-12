{ pkgs, ... }:
{
  imports = [
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
    ./swaybar
  ];

  home.packages = with pkgs; [
    slurp
    grim
    wf-recorder
    wl-clipboard
    wl-mirror
    wl-mirror-pick
    ydotool
    primary-xwayland
    pulseaudio
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}