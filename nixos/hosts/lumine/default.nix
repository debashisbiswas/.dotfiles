{
  imports = [
    ../../configuration.nix
    ./nvidia.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "lumine";
  system.stateVersion = "23.11";
}
