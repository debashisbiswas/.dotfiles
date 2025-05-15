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

  services.fstrim.enable = true;
  modules.gaming.enable = false;

  system.stateVersion = "23.11";
}
