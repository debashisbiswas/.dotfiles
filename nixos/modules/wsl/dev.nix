{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    curl
    gcc
    gdb
    git
    htop
    jq
    nmap
    sqlite
    stow
    tmux
    tree
    unzip
    vim
    wget
    zip

    bat
    eza
    fd
    fzf
    ripgrep

    doppler
    gh
    starship

    repomix
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

