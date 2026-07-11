{ pkgs, ... }:

{
  home.packages = with pkgs; [
    beamPackages.elixir
    beamPackages.erlang
    gleam
    elixir-ls
  ];
}

