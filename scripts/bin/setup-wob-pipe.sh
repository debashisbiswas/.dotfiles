#!/usr/bin/env bash

PIPE_PATH="$XDG_RUNTIME_DIR/wob"

rm "$PIPE_PATH" -f && # silently remove the pipe if it exists
mkfifo "$PIPE_PATH" &&
tail -f "$PIPE_PATH" | wob
