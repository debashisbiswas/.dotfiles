{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cljfmt
    clojure-lsp
    leiningen
  ];
}
