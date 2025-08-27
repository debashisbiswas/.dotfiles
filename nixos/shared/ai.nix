{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    inputs.nixpkgs-master.legacyPackages.${pkgs.system}.opencode
  ];
}
