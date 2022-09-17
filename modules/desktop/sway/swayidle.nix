# { pkgs, user, bg-path, ... }: {
#   services.swayidle = {
#     enable = true;
#     timeouts = [{
#       timeout = 5 * 60;
#       command = "swaylock";
#     }];
#     events = [
#       {
#         event = "before-sleep";
#         command = "swaylock";
#       }
#       {
#         event = "lock";
#         command = "swaylock";
#       }
#     ];
#   };
# }

# File that defines how the workstation is locked
# Describes swaylock and swayidle behavior
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ swayidle ];

  systemd.user.services.swayidle = {
    description = "Idle Manager for Wayland";
    documentation = [ "man:swayidle(1)" ];
    wantedBy = [ "sway-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w -d \
               timeout 600 'systemctl suspend'
      '';
    };
  };
}
