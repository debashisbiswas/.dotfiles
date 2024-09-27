#!/usr/bin/env bash

# List available sinks with index and description
sinks=$(pactl list short sinks | awk '{print $1, $2}')

# Use fzf to select a sink
selected_sink=$(echo "$sinks" | fzf --prompt="Select an audio output: " --height=10 --reverse)

# Extract the sink index from the selected line
sink_index=$(echo "$selected_sink" | awk '{print $1}')

# If a valid sink is selected, switch to it
if [[ -n "$sink_index" ]]; then
    pactl set-default-sink "$sink_index"
    echo "Switched to sink $sink_index"
else
    echo "No sink selected."
fi
