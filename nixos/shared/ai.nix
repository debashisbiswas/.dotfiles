{ pkgs, ... }:

let
  opencode = pkgs.callPackage ../pkgs/opencode.nix { };
in
{
  home.packages = with pkgs; [
    claude-code
    amp-cli
    opencode
  ];
}

