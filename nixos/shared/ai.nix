{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    codex
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
