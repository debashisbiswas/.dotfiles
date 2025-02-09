#!/usr/bin/env bash

# If there is nothing to find on this port, prints an empty string.
get_docker_info() {
    local port=$1
    docker ps --format "{{.Names}} ({{.Image}})" -f "publish=$port" 2>/dev/null
}

ss -tlnpH 2>/dev/null | while read -r line; do
    port=$(echo "$line" | awk '{print $4}' | sed 's/.*://')
    process=$(echo "$line" | grep -o '".*"' | tr -d '"')
    docker_info=$(get_docker_info "$port")

    if [ ! -z "$docker_info" ]; then
        echo -e "$port\t$docker_info [docker]"
    elif [ ! -z "$process" ]; then
        echo -e "$port\t($process)"
    else
        echo "$port"
    fi
done | sort -n | uniq | fzf --reverse | awk '{ print $1 }' | xargs -I{} xdg-open "http://localhost:{}"
