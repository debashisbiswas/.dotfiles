{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    pandoc
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
