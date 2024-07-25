{ inputs, ... }:
{
  imports = [
    ../../configuration.nix
    inputs.hardware.nixosModules.common-gpu-amd

    ./hardware-configuration.nix
  ];

  networking.hostName = "lumine";

  services.fstrim.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.amdgpu.opencl.enable = true;

  system.stateVersion = "23.11";
}
