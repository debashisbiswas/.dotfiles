{ pkgs, ... }:

{
  home.packages = with pkgs; [
    work-sans
    fira
    fira-code
    roboto-mono
    iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    takao
    ibm-plex
    etBook
    vollkorn
    libertine
  ];
}