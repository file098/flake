{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  boot.kernelModules = [ "coretemp" "cpuid" ];
}
