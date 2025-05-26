{ pkgs, inputs, ... }:

let
  user = "violet";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
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

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };

    taps = [
      "railwaycat/emacsmacport"
    ];

    casks = [
      "android-studio"
      "bitwarden"
      "brave-browser"
      "discord"
      "docker"
      "emacs-mac"
      "obsidian"
      "raycast"
      "spotify"
      "tailscale"
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

