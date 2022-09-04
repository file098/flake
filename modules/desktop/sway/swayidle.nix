{ config, pkgs, user, ... }: {
  home-manager.users."${user}" = {
    services.swayidle = {
      enable = true;
      package = pkgs.swayidle;
      events = [
        {
          event = "before-sleep";
          command = "swaylock";
        }
        {
          event = "lock";
          command = "swaylock";
        }
        {
          event = "after-resume";
          command = "swaylock";
        }

      ];
      timeouts = [{
        timeout = 60;
        command = "swaylock -fF";
      }];
    };
  };
}
