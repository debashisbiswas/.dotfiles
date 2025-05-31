{ config, pkgs, inputs, ... }:

let
  user = "violet";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix.settings.warn-dirty = false;
  nixpkgs.config.allowUnfree = true;

  users.users.violet = {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  system.primaryUser = user;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = [
    # Essential system tools that should be available system-wide
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "vale";

  system.activationScripts.postActivation.text = ''
    echo "[Rosetta] Checking if installed..."
    if ! /usr/bin/pgrep oahd > /dev/null 2>&1; then
      echo "[Rosetta] Installing..."
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    else
      echo "[Rosetta] Already installed."
    fi
  '';

  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-emacsmacport" = inputs.homebrew-emacsmacport;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };

    # https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    taps = builtins.attrNames config.nix-homebrew.taps;

    casks = [
      "android-studio"
      "bitwarden"
      "brave-browser"
      "discord"
      "docker"
      "emacs-mac"
      "flutter"
      "google-chrome"
      "obsidian"
      "raycast"
      "signal"
      "spotify"
      "tailscale"
      "ticktick"
      "visual-studio-code"
      "wezterm"
      "zed"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.violet = import ../../home-darwin.nix;
  };
}

