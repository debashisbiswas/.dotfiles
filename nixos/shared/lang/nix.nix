{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
    nixfmt-classic
    nix-search-cli
  ];
}