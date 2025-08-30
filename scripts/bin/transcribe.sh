#!/usr/bin/env bash

TRANSCRIPTION_SERVER="https://vale.queue-mixolydian.ts.net/transcribe"

cleanup_and_exit() {
    echo "Recording cancelled" >&2
    rm -f "$TEMP_FILE"
    exit 0
}

trap cleanup_and_exit SIGINT SIGTERM

echo "Checking transcription server..." >&2
if ! curl -s --max-time 5 --head "$TRANSCRIPTION_SERVER" >/dev/null; then
    echo "Transcription server is not available" >&2
    exit 1
fi

echo "Initializing audio..." >&2
if ! ffmpeg -f pulse -i default -t 0.1 -f null - -loglevel quiet 2>/dev/null; then
    echo "Audio initialization failed" >&2
    exit 1
fi

TEMP_FILE=$(mktemp --suffix=.wav)

echo "Recording started. Press 'q' to stop and transcribe, 'Ctrl+C' to cancel..." >&2

ffmpeg -f pulse -i default "$TEMP_FILE" -loglevel quiet -y
FFMPEG_EXIT_CODE=$?

if [ $FFMPEG_EXIT_CODE -eq 0 ] || [ $FFMPEG_EXIT_CODE -eq 255 ]; then
    echo "Transcribing..." >&2
    curl -s "$TRANSCRIPTION_SERVER" \
          -X POST \
          -F file="@$TEMP_FILE"
    rm $TEMP_FILE
else
    echo "Recording failed" >&2
    rm -f $TEMP_FILE
    exit 1
fi

