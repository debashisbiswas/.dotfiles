{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt
    nix-search-cli
  ];
}
