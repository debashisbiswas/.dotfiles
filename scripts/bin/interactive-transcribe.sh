#!/usr/bin/env bash

cleanup_and_exit() {
    rm -f "$TEMP_OUTPUT" 2>/dev/null
    exit 0
}

trap cleanup_and_exit SIGINT SIGTERM

TEMP_OUTPUT=$(mktemp)
$HOME/bin/transcribe.sh > "$TEMP_OUTPUT"
TRANSCRIBE_EXIT_CODE=$?

if [ $TRANSCRIBE_EXIT_CODE -ne 0 ]; then
    rm -f "$TEMP_OUTPUT"
    exit 0
fi

TRANSCRIPTION=$(cat "$TEMP_OUTPUT")
rm -f "$TEMP_OUTPUT"

clear

echo "----------------------------------------"
echo "$TRANSCRIPTION"
echo "----------------------------------------"

echo "Options:"
echo "  [c] Copy to clipboard"
echo "  [s] Save to file"
echo "  [e] Edit before copying"
echo "  [q] Quit"
echo
echo -n "Choose an option: "

read -n 1 CHOICE
echo

case "$CHOICE" in
    c|C)
        echo "$TRANSCRIPTION" | wl-copy
        echo "Copied to clipboard!"
        ;;
    s|S)
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        FILENAME="$HOME/transcription_$TIMESTAMP.txt"
        echo "$TRANSCRIPTION" > "$FILENAME"
        echo "Saved to $FILENAME"
        ;;
    e|E)
        TEMP_FILE=$(mktemp)
        echo "$TRANSCRIPTION" > "$TEMP_FILE"
        ${EDITOR:-nano} "$TEMP_FILE"
        EDITED_CONTENT=$(cat "$TEMP_FILE")
        echo "$EDITED_CONTENT" | wl-copy
        rm "$TEMP_FILE"
        echo "Edited text copied to clipboard!"
        ;;
    q|Q)
        echo "Goodbye!"
        ;;
    *)
        echo "Unknown option. Exiting..."
        ;;
esac

echo "Press any key to exit..."
read -n 1
