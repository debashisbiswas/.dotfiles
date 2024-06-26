# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;

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
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=2
    '';
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
      defaultSession = "none+i3";
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
          brightnessctl
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

    # DE will usually provide this, but i3 won't
    blueman.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Bluetooth
  hardware = {
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Enable sound with pipewire.
  sound.enable = true;
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
      eza
      fd
      ffmpeg
      fzf
      gcc
      gh
      git
      glow
      gphoto2
      htop
      imagemagick
      jq
      mpv
      mysql
      neofetch
      nix-search-cli
      nmap
      pciutils
      postgresql
      pulumi
      pulumiPackages.pulumi-language-nodejs
      ripgrep
      starship
      stow
      terraform
      tmux
      unzip
      usbutils
      v4l-utils
      xclip

      # gui
      alacritty
      brave
      calibre
      discord
      droidcam
      firefox
      gtk3
      lxappearance
      obs-studio
      obsidian
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
      rustup
      zig

      # erlang and adjacent
      erlang
      rebar3
      elixir
      gleam
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira
      iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      takao
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
    spotify
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    fish.enable = true;
    dconf.enable = true;
    neovim.enable = true;
    adb.enable = true;

    # https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
    # This is useful for Neovim language servers installed through Mason, for example.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    57621 # spotify
    4747 # droidcam
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # spotify
    4747 # droidcam
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
