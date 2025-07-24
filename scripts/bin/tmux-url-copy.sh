#!/usr/bin/env bash

url=$(cat /tmp/tmux-buffer | extract-url.sh)

if [ -n "$url" ]; then
    echo "$url" | copy-to-clipboard.sh
    echo "Copied to clipboard: $url"
    sleep 1
else
    echo "No URL selected or found"
    sleep 1
fi
