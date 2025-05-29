{ pkgs, ... }:

{
  imports = [
    ./ai.nix
    ./fonts.nix

    ./lang/clojure.nix
    ./lang/elixir.nix
    ./lang/flutter.nix
    ./lang/go.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/python.nix
    ./lang/rust.nix
    ./lang/shell.nix
    ./lang/terraform.nix
    ./lang/web.nix
    ./lang/zig.nix
  ];

  home.packages = with pkgs; [
    vim
    neovim

    ansible
    awscli2
    bat
    btop
    dig
    direnv
    doppler
    editorconfig-core-c
    eza
    fd
    ffmpeg
    fzf
    zip
    unzip
    gcc
    gh
    git
    glow
    gnumake
    htop
    imagemagick
    jq
    mariadb
    neofetch
    nmap
    pandoc
    postgresql
    tailscale
    # pulumi
    # pulumiPackages.pulumi-language-nodejs
    railway
    repomix
    ripgrep
    sqlite
    starship
    stow
    tmux
    unzip
    zip
    zk
  ];
}

