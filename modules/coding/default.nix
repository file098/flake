{ pkgs, ... }: {

  home.packages = with pkgs; [ maven jdk spring-boot-cli h2 beekeeper-studio nodePackages.nodemon ];

}
