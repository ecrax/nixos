{
  flake.modules.nixos.power-manager = {
    powerManagement.cpuFreqGovernor = "performance";
  };
}
