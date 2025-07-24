#!/usr/bin/env bash

if command -v pbcopy >/dev/null; then
    pbcopy
elif command -v xclip >/dev/null; then
    xclip -selection clipboard
elif command -v wl-copy >/dev/null; then
    wl-copy
else
    echo "No clipboard utility found" >&2
    exit 1
fi
