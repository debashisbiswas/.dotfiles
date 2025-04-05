#!/usr/bin/env bash

dmenu_path | fzf --reverse | xargs hyprctl dispatch exec
