{ pkgs, ... }:

let
  opencode = pkgs.callPackage ../pkgs/opencode.nix { };
in
{
  home.packages =
    with pkgs;
    [
      claude-code
      amp-cli
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      opencode
    ];
}
