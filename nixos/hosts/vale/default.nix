{
  config,
  pkgs,
  inputs,
  ...
}:

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
      "nikitabobko/homebrew-tap" = inputs.nikitabobko-tap;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  # To upgrade, update the homebrew flake inputs, rebuild, then `brew upgrade`
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };

    # https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    taps = builtins.attrNames config.nix-homebrew.taps;

    # TODO: docker was renamed to docker-desktop. There wasn't a warning, but
    # an issue with docker re-installing itself. On every rebuild. Something
    # similar happened with Tailscale. Use `brew list --versions` to see rename
    # warnings for now. Is there a way to get warnings when rebuilding?
    casks = [
      "android-studio"
      "bitwarden"
      "brave-browser"
      "calibre"
      "claude"
      "discord"
      "docker-desktop"
      "flutter"
      "google-chrome"
      "jellyfin-media-player"
      "libreoffice"
      "obs"
      "obsidian"
      "raycast"
      "signal"
      "spotify"
      "superwhisper"
      "tailscale-app"
      "ticktick"
      "visual-studio-code"
      "wezterm"
      "zed"
      "zoom"

      "nikitabobko/tap/aerospace"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.violet = import ../../home-darwin.nix;
  };
}
