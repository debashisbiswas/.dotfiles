{ pkgs, ... }:

{
  home.packages = with pkgs; [
    elixir
    erlang
    gleam
    elixir-ls
  ];
}