{ }: {
  specialisation = {

    nvidia = {
      inheritParentConfig = false; # whether the config is from scratch
      configuration = {
        system.nixos.tags = [ "nvidia" ];
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.opengl.enable = true;
        hardware.nvidia = {
          modesetting.enable = true;
          # Optionally, you may need to select the appropriate driver version for your specific GPU.
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          powerManagement.enable = true;
        };
        environment.systemPackages = with pkgs; [ nvtop ];
      };
    };
  };
}
