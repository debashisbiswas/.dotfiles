{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    inputs.nixpkgs-master.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
  ];
}
