{ user, ... }:

{
  programs = {
    npm = {
      enable = true;
      npmrc = ''
        prefix = /home/${user}/.npm-packages
      '';
    };
  };
}
