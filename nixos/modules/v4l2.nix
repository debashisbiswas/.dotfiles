{ config, ... }:

{
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  # Register a v4l2loopback device at boot
  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="virtual camera"
  '';
}
