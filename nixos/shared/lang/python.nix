{ pkgs, ... }:

{
  home.packages = with pkgs; [
    basedpyright
    python3
    pyright
    ruff
    uv
  ];
}
