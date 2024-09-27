#!/usr/bin/env bash

# Function to get the list of audio inputs
get_inputs() {
    pactl list short sinks | awk '{print $2}'
}

# Function to switch the audio input
switch_input() {
    pactl set-default-sink "$1"
    notify-send "Switched to $1"
}

# Main menu function
show_menu() {
    local inputs=($(get_inputs))
    local keys=("f" "d" "s" "a" "j" "k" "l" ";")
    
    echo "Select audio input:"
    for i in "${!inputs[@]}"; do
        if [ $i -lt ${#keys[@]} ]; then
            echo "${keys[$i]}) ${inputs[$i]}"
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
    
    notify-send "Invalid selection"
}

show_menu
