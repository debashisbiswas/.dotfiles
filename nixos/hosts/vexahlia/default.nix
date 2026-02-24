{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default

    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "vexahlia";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Phoenix";

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

  users.users.violet = {
    isNormalUser = true;
    description = "Debashis Biswas";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    linger = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +10"; # number of generations
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  services.tailscale.enable = true;

  services.jellyfin =
    let
      jellyfin-base = "/srv/jellyfin";
    in
    {
      enable = true;
      dataDir = jellyfin-base;
      configDir = "${jellyfin-base}/config";
      cacheDir = "${jellyfin-base}/cache";
      logDir = "${jellyfin-base}/log";
    };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.violet = import ./home.nix;
  };

  system.stateVersion = "25.11";
}
