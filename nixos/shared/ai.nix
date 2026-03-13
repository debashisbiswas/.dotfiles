{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    amp-cli
    claude-code
    codex
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
  ];
}
