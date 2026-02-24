#!/usr/bin/env bash

set -euxo pipefail

nix run nixpkgs#nixos-rebuild -- switch \
  --flake "$DOTFILES/nixos#vexahlia" \
  --target-host violet@vexahlia \
  --build-host violet@vexahlia \
  --ask-sudo-password
