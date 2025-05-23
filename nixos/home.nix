{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "violet";
  home.homeDirectory = "/home/violet";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # cli
    aider-chat
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
    gphoto2
    home-manager
    htop
    imagemagick
    jq
    mariadb
    mpv
    neofetch
    nix-search-cli
    nixfmt-classic
    nmap
    pandoc
    pciutils
    postgresql
    # pulumi
    # pulumiPackages.pulumi-language-nodejs
    railway
    ripgrep
    shellcheck
    sqlite
    starship
    stow
    tailscale
    terraform
    tmux
    unzip
    usbutils
    v4l-utils
    wally-cli
    xclip

    # gui
    alacritty
    brave
    calibre
    code-cursor
    vscode
    discord
    firefox
    foliate
    ghostty
    gtk3
    lxappearance
    musescore
    obsidian
    obs-studio
    pavucontrol
    signal-desktop
    slack
    tana
    ticktick
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    zed-editor

    # languages
    bun
    go
    nodejs
    python3
    racket-minimal
    rustup # includes cargo, rust-analyzer
    zig

    # language tooling
    astro-language-server
    clojure-lsp
    cljfmt
    delve
    emmet-language-server
    gopls
    leiningen
    lexical
    ltex-ls-plus
    lua-language-server
    nixd
    nixpkgs-fmt
    prettierd
    pyright
    ruff
    stylua
    svelte-language-server
    tailwindcss-language-server
    terraform-ls
    typescript-language-server
    uv
    vscode-langservers-extracted # html, css, json, eslint, md
    yarn-berry

    # erlang and adjacent
    erlang
    rebar3
    elixir
    inotify-tools
    gleam

    # idk
    libreoffice-qt
    hunspell

    # desktop environment
    bluetui
    brightnessctl
    clipse
    hyprpicker
    hyprshot
    libnotify
    mako
    networkmanagerapplet
    nwg-look
    overskride # tuis are cool until you need to connect a bluetooth keyboard
    swww
    waybar
    wl-clipboard
    wl-clipboard
    wlsunset

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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" '' echo "Hello, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/violet/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs30-pgtk;
      extraPackages = epkgs: with epkgs; [ vterm ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
