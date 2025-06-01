{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # install rust-analyzer with `rustup component add rust-analyzer`
    # https://rust-analyzer.github.io/book/rust_analyzer_binary.html#rustup
    #
    # Ensure that cc points to /usr/bin/cc on darwin - if something else is in
    # the path, (for example, by installing the gcc wrapper script from nixpkgs),
    # rust builds will fail.
    # https://github.com/NixOS/nixpkgs/issues/206242
    rustup
  ];
}
