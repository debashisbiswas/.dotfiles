{ pkgs, inputs, ... }:

{
  home.packages =
    with pkgs;
    [
      claude-code
      amp-cli
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      # TODO: remove nixpkgs-master once opencode is in nixpkgs unstable?
      # opencode updates fast - we'll see how closely unstable can keep up
      inputs.nixpkgs-master.legacyPackages.${pkgs.system}.opencode
    ];
}
