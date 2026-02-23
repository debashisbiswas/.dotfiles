#!/usr/bin/env bash

set -euxo pipefail

nix run nixpkgs#nixos-rebuild -- switch \
  --flake "$DOTFILES/nixos#vexahlia" \
  --target-host violet@vexahlia.queue-mixolydian.ts.net \
  --build-host violet@vexahlia.queue-mixolydian.ts.net \
  --ask-sudo-password
