{pkgs}:
{
      users.users.file0 = {
    isNormalUser = true;
    home = "/home/file0";
    description = "Filippo";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "jackaudio"
      "audio"
      "sound"
      "input"
      "tty"
    ];
    shell = pkgs.zsh;
  };
}