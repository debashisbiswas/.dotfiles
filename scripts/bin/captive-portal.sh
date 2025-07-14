#!/usr/bin/env bash

if ! curl -s --max-time 5 http://clients3.google.com/generate_204 > /dev/null; then
    echo "No internet detected, opening captive portal..."
    xdg-open http://neverssl.com
else
    echo "Internet connection is working"
fi
