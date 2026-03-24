#!/usr/bin/env bash

set -euxo pipefail

# Work around Tailscale SSH multiplexing protocol mismatch:
# https://github.com/tailscale/tailscale/issues/14093
NIX_SSHOPTS="-o ControlMaster=no -o ControlPath=none -o ControlPersist=no" \
	nix run nixpkgs#nixos-rebuild -- switch \
	--flake "$DOTFILES/nixos#vexahlia" \
	--target-host root@vexahlia \
	--build-host root@vexahlia \
	--no-reexec
