{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-openclaw.homeManagerModules.openclaw
  ];

  home = {
    username = "violet";
    homeDirectory = "/home/violet";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  programs.openclaw = {
    enable = true;
    package = inputs.nix-openclaw.packages.${pkgs.system}.openclaw;

    bundledPlugins.goplaces.enable = false;

    config = {
      gateway = {
        mode = "local";
        bind = "loopback";
        auth.mode = "none";
      };
    };
  };
}
