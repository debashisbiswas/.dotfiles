{
  imports = [
    ../../configuration.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "lumine";
  system.stateVersion = "23.11";
}
