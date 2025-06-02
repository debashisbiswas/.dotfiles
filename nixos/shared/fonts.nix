{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    etBook
    fira
    fira-code
    ibm-plex
    iosevka
    libertine
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto
    roboto-mono
    takao
    vollkorn
    work-sans
  ];
}

