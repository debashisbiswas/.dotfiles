{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    amp-cli
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    codex
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
  ];
}
