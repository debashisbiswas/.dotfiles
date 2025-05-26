{ pkgs }:

with pkgs; [
  vim
  neovim

  # cli
  amp-cli
  ansible
  awscli2
  btop
  claude-code
  dig
  direnv
  doppler
  editorconfig-core-c
  eza
  fd
  ffmpeg
  fzf
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
  nix-search-cli
  nixfmt-classic
  nmap
  pandoc
  postgresql
  tailscale
  # pulumi
  # pulumiPackages.pulumi-language-nodejs
  railway
  ripgrep
  sqlite
  starship
  stow
  terraform
  tmux

  # languages
  bun
  elixir
  erlang
  gleam
  go
  nodejs
  python3
  racket-minimal
  rustup # includes cargo, rust-analyzer
  zig

  # Language tooling
  astro-language-server
  delve
  emmet-language-server
  elixir-ls
  gopls
  lua-language-server
  nixd
  nixpkgs-fmt
  prettierd
  pyright
  ruff
  shfmt
  shellcheck
  stylua
  svelte-language-server
  tailwindcss-language-server
  terraform-ls
  typescript-language-server
  uv
  vscode-langservers-extracted
  vtsls
  yarn-berry

  # fonts
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
]

