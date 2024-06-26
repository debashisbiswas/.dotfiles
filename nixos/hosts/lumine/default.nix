{ inputs, ... }:
{
  imports = [
    ../../configuration.nix
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-cpu-intel-kaby-lake

    ./hardware-configuration.nix
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
