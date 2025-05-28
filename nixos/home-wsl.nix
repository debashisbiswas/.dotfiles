{ pkgs, ... }:

let
  user = "dbiswas";
in
{
  imports = [
    ./shared/packages.nix

    ./modules/wsl/dev.nix
    ./modules/wsl/editor.nix
    ./modules/wsl/lang/java.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";
    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 12;
      gtk.enable = true;
    };
  };

  home.packages = with pkgs; [
    wl-clipboard

    # oracle
    oracle-instantclient
    sqlcl
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

