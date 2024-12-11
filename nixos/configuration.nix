# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default

    ./modules/v4l2.nix
    ./modules/spotify.nix
  ];

  nix = {
    package = pkgs.nixVersions.latest;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  time.timeZone = "America/Phoenix";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # part of i3 config?
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services = {
    displayManager = {
      defaultSession = "Hyprland";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;

        # TODO: decrease touchpad scroll sensitivity
        # https://man.archlinux.org/man/libinput.4#SCROLL_PIXEL_DISTANCE
        additionalOptions =
          ''
            Option "ScrollPixelDistance" "50"
          '';
      };
      # TODO: touchpad gestures
    };

    xserver = {
      enable = true;
      xkb.layout = "us";

      desktopManager.xterm.enable = false;

      displayManager.gdm.enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          dunst
          feh
          i3lock
          i3status
          maim
          picom
          playerctl
          redshift
          rofi
        ];
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # These are all used for mounting USB devices when plugged in.
    udisks2.enable = true; # calibre needs to be able to see connected e-readers
    devmon.enable = true;
    gvfs.enable = true;

    ollama.enable = true;

    emacs.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  hardware = {
    # Bluetooth
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    keyboard.zsa.enable = true; # https://nixos.wiki/wiki/ZSA_Keyboards
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.violet = {
    isNormalUser = true;
    description = "Debashis Biswas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # cli
      ansible
      awscli2
      btop
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
      htop
      imagemagick
      jq
      mariadb
      mpv
      ncspot
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
      vscode
      discord
      firefox
      foliate
      gtk3
      lxappearance
      musescore
      obsidian
      obs-studio
      pavucontrol
      signal-desktop
      ticktick
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      zoom-us

      # languages
      go
      nodejs
      python3
      racket-minimal
      rustup
      zig

      # language tooling
      astro-language-server
      delve
      emmet-language-server
      gopls
      lexical
      lua-language-server
      nil
      nixpkgs-fmt
      prettierd
      pyright
      ruff
      rust-analyzer
      svelte-language-server
      tailwindcss-language-server
      terraform-ls
      typescript-language-server
      vscode-langservers-extracted # html, css, json, eslint, md

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
      brightnessctl
      clipse
      hyprshot
      libnotify
      mako
      networkmanagerapplet
      nwg-look
      swww
      waybar
      wl-clipboard
      wl-clipboard
      wlsunset
      wofi
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      violet = import ./home.nix;
    };
  };

  services.gnome.gnome-keyring.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira
      iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      takao
      ibm-plex
    ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  # TODO: doesn't work yet...
  xdg.mime.defaultApplications =
    let
      defaultBrowser = "brave-browser.desktop";
    in
    {
      "text/html" = defaultBrowser;
      "x-scheme-handler/http" = defaultBrowser;
      "x-scheme-handler/https" = defaultBrowser;
      "x-scheme-handler/about" = defaultBrowser;
      "x-scheme-handler/unknown" = defaultBrowser;
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git # for flakes
    vim
    pulseaudio
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;
    neovim.enable = true;
    adb.enable = true;
    hyprlock.enable = true;

    # https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
    # This is useful for Neovim language servers installed through Mason, for example.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;

    # gtk portal for file pickers
    # https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Disable the firewall altogether.
  # networking.firewall.enable = false;
}
