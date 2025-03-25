# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default

    ./modules/v4l2.nix
    ./modules/spotify.nix
    ./modules/hyprland.nix
    ./modules/print.nix
    ./modules/syncthing.nix
    ./modules/vm.nix
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
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
      defaultSession = "hyprland";
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

    # These are all used for mounting USB devices when plugged in.
    udisks2.enable = true; # calibre needs to be able to see connected e-readers
    devmon.enable = true;
    gvfs.enable = true;

    ollama.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  hardware = {
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    keyboard.zsa.enable = true; # https://nixos.wiki/wiki/ZSA_Keyboards
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      violet = import ./home.nix;
    };
  };

  fonts = { enableDefaultPackages = true; };

  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
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

    # Keyring
    gnome-keyring
    libsecret
    libgnome-keyring
    gcr
  ];

  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = with pkgs; [ gnome-keyring gcr ];

  security.pam.services = {
    login.enableGnomeKeyring = true;
    gdm.enableGnomeKeyring = true;
  };

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
    seahorse.enable = true;

    # https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
    # This is useful for Neovim language servers installed through Mason, for example.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];

    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services.tailscale.enable = true;

  # Disable the firewall altogether.
  # networking.firewall.enable = false;

  # react native expo
  networking.firewall.allowedTCPPorts = [ 8081 ];
}
