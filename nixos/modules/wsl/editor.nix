{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    pandoc
    texliveBasic
    ispell
    editorconfig-core-c
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        vterm
        treesit-grammars.with-all-grammars
      ];
  };
}
