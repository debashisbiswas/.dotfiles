#!/usr/bin/env bash

# Sink # -> sink description
get_sink_description() {
    pactl list sinks | grep -A3 "Sink #$1" | grep Description | sed "s/^[ \t]*Description: //g"
}

# Function to get the list of audio inputs
get_inputs() {
    pactl list short sinks | awk '{print $1}'
}

# Function to switch the audio input
switch_input() {
    pactl set-default-sink "$1"
    local sink_description=$(get_sink_description "$1")
    notify-send "Switched to $sink_description" -t 2500
}

# Main menu function
show_menu() {
    local inputs=($(get_inputs))
    local keys=("f" "d" "s" "a" "j" "k" "l" ";")
    
    echo "Select audio input:"
    for i in "${!inputs[@]}"; do
        local current=${inputs[$i]}
        local sink_description=$(get_sink_description "$current")

        if [ $i -lt ${#keys[@]} ]; then
            echo "${keys[$i]}) ${sink_description}"
        fi
    done
    
    read -n 1 -s choice
    echo

    for i in "${!keys[@]}"; do
        if [[ "${keys[$i]}" == "$choice" && $i -lt ${#inputs[@]} ]]; then
            switch_input "${inputs[$i]}"
            return
        fi
    done
}

show_menu
