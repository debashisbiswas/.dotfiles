{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cocoapods
    flutter
  ];
}

