{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    amp-cli
  ];
}

