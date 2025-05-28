{ pkgs, ... }:

let
  user = "violet";
in
{
  imports = [
    ./shared/packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    # libvterm
    cmake
    glibtool

    # emacs - dired
    coreutils-prefixed
  ];

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}

