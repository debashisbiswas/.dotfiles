#!/usr/bin/env bash

set -euxo pipefail

nix run nixpkgs#nixos-rebuild -- switch \
  --flake "$DOTFILES/nixos#vexahlia" \
  --target-host root@vexahlia \
  --build-host root@vexahlia \
  --no-reexec
