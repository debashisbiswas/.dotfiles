{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    et-book
    fira
    fira-code
    ibm-plex
    iosevka # why can't emacs find the font when I use iosevka-bin?
    (iosevka-bin.override { variant = "Aile"; })
    (iosevka-bin.override { variant = "Etoile"; })
    libertine
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    roboto
    roboto-mono
    sarasa-gothic
    takao
    vollkorn
    work-sans
  ];
}
