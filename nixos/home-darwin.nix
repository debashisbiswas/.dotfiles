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
    # emacs - dired
    coreutils-prefixed
  ];

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/395169
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs: [ epkgs.vterm ];
    };
  };
}
