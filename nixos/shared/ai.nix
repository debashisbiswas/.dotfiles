{ pkgs, inputs, ... }:

let
  opencode-latest =
    inputs.nixpkgs-master.legacyPackages.${pkgs.system}.opencode.overrideAttrs
      (oldAttrs: {
        version = "0.5.10";

        src = pkgs.fetchFromGitHub {
          owner = "sst";
          repo = "opencode";
          tag = "v0.5.10";
          hash = "sha256-dodzf+WiSaxPczIwuFqNd/TiyEB2iJaR90ZGuQ9zk+Q=";
        };

        tui = oldAttrs.tui.overrideAttrs (tuiAttrs: {
          vendorHash = "sha256-acDXCL7ZQYW5LnEqbMgDwpTbSgtf4wXnMMVtQI1Dv9s=";
        });

        node_modules = oldAttrs.node_modules.overrideAttrs (nodeAttrs: {
          outputHash = "sha256-hznCg/7c9uNV7NXTkb6wtn3EhJDkGI7yZmSIA2SqX7g=";
        });
      });
in
{
  home.packages = with pkgs; [
    claude-code
    opencode-latest
  ];
}
