{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
