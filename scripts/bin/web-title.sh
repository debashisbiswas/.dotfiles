#!/bin/sh

curl -Ls "$1" | grep -oP '(?<=<title>).*?(?=</title>)' | head -n 1 | htmldecode.sh
