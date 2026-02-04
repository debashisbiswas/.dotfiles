{ pkgs, ... }:

{
  imports = [
    ./ai.nix
    ./fonts.nix

    ./lang/clojure.nix
    ./lang/data.nix
    ./lang/elixir.nix
    ./lang/flutter.nix
    ./lang/go.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/python.nix
    ./lang/rust.nix
    ./lang/shell.nix
    ./lang/terraform.nix
    ./lang/text.nix
    ./lang/web.nix
    ./lang/zig.nix
  ];

  home.packages = with pkgs; [
    vim
    neovim

    awscli2
    bat
    btop
    dig
    direnv
    doppler
    editorconfig-core-c
    fd
    ffmpeg
    fzf
    gh
    git
    glow
    gnumake
    htop
    imagemagick
    jq
    mariadb
    nmap
    postgresql
    tailscale
    railway
    ripgrep
    sqlite
    starship
    stow
    tmux
    unzip
    wrangler
    zip
    zoxide

    # emacs - dirvish previews
    # https://github.com/alexluigit/dirvish/blob/main/docs/CUSTOMIZING.org#install-dependencies-for-an-enhanced-preview-experience
    vips
    poppler-utils
    ffmpegthumbnailer
  ];
}
