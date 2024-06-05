{ inputs, ... }:
{
  imports = [
    ../../configuration.nix
    inputs.hardware.nixosModules.lenovo-thinkpad-t480

    ./hardware-configuration.nix
  ];

  networking.hostName = "mipha";
  system.stateVersion = "23.11";
}
