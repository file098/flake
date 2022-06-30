{ pkgs, ... }: 

{

  services = {
    
    openssh = {
      enable = true;
      ports = [ 2242 ];
      logLevel = "VERBOSE";
    };

    fail2ban = { enable = true; };
  };

}