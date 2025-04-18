{ inputs, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-gpu-amd

    ../../modules/vm.nix
  ];

  networking.hostName = "lumine";

  services.fstrim.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  system.stateVersion = "23.11";
}
