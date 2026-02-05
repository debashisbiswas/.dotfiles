{ pkgs, ... }:

let
  user = "violet";
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shared/packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
    };

    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    # TOOD: maybe this should be a shared package, but be careful not to
    # override darwin's cc; there was an issue with this but I can't remember
    # what it was
    gcc

    # cli
    android-tools
    gphoto2
    home-manager
    mpv
    pciutils
    unzip
    usbutils
    v4l-utils
    wally-cli
    xclip

    # gui
    alacritty
    anki
    brave
    calibre
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
    thunar
    thunar-archive-plugin
    thunar-volman
    zed-editor

    inotify-tools # elixir! only needed on linux
    rebar3 # TODO: maybe can be shared

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
    wlsunset
    wob
  ];

  fonts.fontconfig.enable = true;

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
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages =
        epkgs: with epkgs; [
          vterm
          treesit-grammars.with-all-grammars
        ];
    };
  };
}
