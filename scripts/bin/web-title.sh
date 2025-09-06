#!/bin/sh

curl -Ls "$1" | rg -oP '(?<=<title>).*?(?=</title>)' | head -n 1 | htmldecode.sh
