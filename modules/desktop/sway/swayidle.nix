{ pkgs, user, bg-path, ... }: {
  services.swayidle = {
    enable = true;
    timeouts = [{
      timeout = 5 * 60;
      command = "swaylock";
    }];
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
      {
        event = "lock";
        command = "swaylock";
      }
    ];
  };
}
