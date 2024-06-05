{
  imports = [
    ../../configuration.nix
    ./nvidia.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "lumine";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  system.stateVersion = "23.11";
}
