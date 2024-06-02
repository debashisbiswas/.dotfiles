# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t480"
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mipha"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # part of i3 config?
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services = {
    displayManager = {
      defaultSession = "none+i3";
      sddm.enable = true;
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
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.touchegg.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # DE will usually provide this, but i3 won't
  services.blueman.enable = true;

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
      brave
      firefox
      obsidian
      pavucontrol
      signal-desktop
      ticktick
      wezterm
      zoom-us
      lxappearance
      discord
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      nix-search-cli

      elixir
      go
      nodejs
      python3
      rustup
      zig

      awscli2
      btop
      eza
      fd
      fzf
      gcc
      gh
      git
      gtk3
      htop
      jq
      mysql
      neovim
      nmap
      pciutils
      postgresql
      pulumi
      pulumiPackages.pulumi-language-nodejs
      ripgrep
      starship
      stow
      tmux
      unzip
      usbutils
      xclip
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
    TERMINAL = "wezterm";
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
  programs.fish.enable = true;
  programs.dconf.enable = true;

  # https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
  # This is useful for Neovim language servers installed through Mason, for example.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    57621 # spotify
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # spotify
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
