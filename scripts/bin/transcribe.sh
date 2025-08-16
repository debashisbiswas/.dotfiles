#!/usr/bin/env bash

WHISPER_SERVER="https://vale.queue-mixolydian.ts.net/inference"

cleanup_and_exit() {
    echo "Recording cancelled" >&2
    rm -f "$TEMP_FILE"
    exit 0
}

trap cleanup_and_exit SIGINT SIGTERM

echo "Checking inference server..." >&2
if ! curl -s --max-time 5 --head "$WHISPER_SERVER" >/dev/null; then
    echo "Inference server is not available" >&2
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
    curl -s "$WHISPER_SERVER" \
          -H "Content-Type: multipart/form-data" \
          -F file="@$TEMP_FILE" \
          -F temperature="0.0" \
          -F temperature_inc="0.2" \
          -F response_format="text"
    rm $TEMP_FILE
else
    echo "Recording failed" >&2
    rm -f $TEMP_FILE
    exit 1
fi

