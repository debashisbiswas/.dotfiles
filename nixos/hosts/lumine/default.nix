{ inputs, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-gpu-amd

    ../../modules/vm.nix
    ../../modules/gaming.nix
  ];

  networking.hostName = "lumine";

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services.fstrim.enable = true;
  modules.gaming.enable = true;

  system.stateVersion = "23.11";
}
