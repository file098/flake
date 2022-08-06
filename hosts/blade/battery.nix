{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersaver";
  };
  # powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  boot.kernelModules = [ "coretemp" "cpuid" ];
}
