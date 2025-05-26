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
    # cli
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
    wl-clipboard
    wlsunset
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

    emacs = {
      enable = true;
      package = pkgs.emacs30-pgtk;
      extraPackages = epkgs: with epkgs; [ vterm ];
    };
  };
}
