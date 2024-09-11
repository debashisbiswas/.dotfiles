#!/bin/bash

get_title() {
    curl -s "$1" | grep -oP '(?<=<title>).*(?=</title>)'
}

if [ -p /dev/stdin ]; then
    while read -r url; do get_title "$url"; done
elif [ $# -eq 1 ]; then
    get_title "$1"
else
    echo "Usage: $0 <URL> or pipe URLs"
fi
