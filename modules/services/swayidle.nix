{ pkgs, user, ... }:

let
  lock_cmd =
    "swaylock -i ${bg-path} --clock --indicator --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 000000 --fade-in 0.5";
in {
  systemd.services.swaylock = {
    before = [ "sleep.target" ];
    serviceConfig.Type = "forking";
    serviceConfig.User = "${user}";
    serviceConfig.ExecStartPost = "${pkgs.coreutils}/bin/sleep 1";
    environment.WAYLAND_DISPLAY = "wayland-1";
    environment.XDG_RUNTIME_DIR = "/run/user/1000";
    wantedBy = [ "sleep.target" ];
    serviceConfig.ExecStart = "${pkgs.swaylock}/bin/${lock_cmd}";
  };

  # playerctl -a pause
  # home-manager.users.avo.systemd.user.services.swaylock = {
  #   Service = {
  #     ExecStart = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
  #     ExecStartPost = "${pkgs.coreutils}/bin/sleep 1";
  #     Type = "forking";
  #     User = "avo";
  #   };
  #   Unit = {
  #     Before = [ "suspend.target" "sleep.target" ];
  #     ConditionEnvironment = "WAYLAND_DISPLAY";
  #     Environment = "WAYLAND_DISPLAY=wayland-1";
  #   };
  #   Install.WantedBy = [ "suspend.target" "sleep.target" ];
  # };

  security.pam.services.swaylock.text = "auth include login";

  # security.pam.services.swaylock = {}

  # - security.pam.services.swaylock.text = builtins.readFile "${pkgs.swaylock}/etc/pam.d/swaylock";
  # + security.pam.services.swaylock.text = builtins.readFile "''${pkgs.swaylock}/etc/pam.d/swaylock";
  # security.pam.services.swaylock.text = lib.fileContents "${pkgs.swaylock}/etc/pam.d/swaylock";
}
