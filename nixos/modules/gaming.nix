{ config, lib, ... }:

with lib;

let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Enable gaming support";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}

