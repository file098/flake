# Nix Package Manager settings
{ pkgs, ... }: {

  nix = {
    # Enable nixFlakes on system
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

}
