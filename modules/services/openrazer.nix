{ pkgs,user, ... }: {

  home.packages = with pkgs; [ 
    openrazer-daemon 
    polychromatic
  ];

}
