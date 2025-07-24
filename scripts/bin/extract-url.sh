#!/usr/bin/env bash

urls=$(grep -oE 'https?://[^[:space:]]+' | sort -u)

if [ -z "$urls" ]; then
    echo "No URLs found" >&2
    exit 1
fi

echo "$urls" | fzf --prompt="Select URL: " --height=40% --reverse

