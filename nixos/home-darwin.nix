{ pkgs, ... }:

let
  user = "violet";
  sharedPackages = import ./shared/packages.nix { inherit pkgs; };
in
{
  home = {
    username = user;
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
  };

  home.packages = sharedPackages ++ (with pkgs; [
    # libvterm
    cmake
    glibtool

    # emacs - dired
    coreutils-prefixed
  ]);

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}

