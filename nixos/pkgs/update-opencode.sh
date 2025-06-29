#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NIX_FILE="$SCRIPT_DIR/opencode.nix"

LATEST_VERSION=$(curl -s https://api.github.com/repos/sst/opencode/releases/latest | jq -r '.tag_name' | sed 's/^v//')
CURRENT_VERSION=$(grep 'version = ' "$NIX_FILE" | sed 's/.*version = "\(.*\)";/\1/')

echo "Current version: $CURRENT_VERSION"
echo "Latest version:  $LATEST_VERSION"

if [[ "$LATEST_VERSION" == "$CURRENT_VERSION" ]]; then
    echo "Already up to date!"
    exit 0
fi

echo
echo "Fetching hashes for all platforms..."

get_hash() {
    local platform=$1
    local url="https://github.com/sst/opencode/releases/download/v${LATEST_VERSION}/opencode-${platform}.zip"
    local hash=$(nix-prefetch-url --type sha256 "$url" 2>/dev/null)
    nix hash to-sri --type sha256 "$hash"
}

HASH_LINUX_X64=$(get_hash "linux-x64")
HASH_LINUX_ARM64=$(get_hash "linux-arm64")
HASH_DARWIN_X64=$(get_hash "darwin-x64")
HASH_DARWIN_ARM64=$(get_hash "darwin-arm64")

echo
echo "Update $NIX_FILE with the following changes:"
echo
echo "1. Change version to: \"$LATEST_VERSION\""
echo
echo "2. Update hashes:"
echo "   x86_64-linux = \"$HASH_LINUX_X64\";"
echo "   aarch64-linux = \"$HASH_LINUX_ARM64\";"
echo "   x86_64-darwin = \"$HASH_DARWIN_X64\";"
echo "   aarch64-darwin = \"$HASH_DARWIN_ARM64\";"
echo
echo "3. Test with: nix-build -E 'with import <nixpkgs> {}; callPackage $NIX_FILE {}'"
