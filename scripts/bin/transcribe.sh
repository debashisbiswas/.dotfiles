#!/usr/bin/env bash

WHISPER_SERVER="https://vale.queue-mixolydian.ts.net/inference"
TEMP_FILE="/tmp/voice.wav"

ffmpeg -f pulse -i default "$TEMP_FILE"
FFMPEG_EXIT_CODE=$?

if [ $FFMPEG_EXIT_CODE -eq 0 ] || [ $FFMPEG_EXIT_CODE -eq 255 ]; then
    curl "$WHISPER_SERVER" \
          -H "Content-Type: multipart/form-data" \
          -F file="@$TEMP_FILE" \
          -F temperature="0.0" \
          -F temperature_inc="0.2" \
          -F response_format="text"
    rm $TEMP_FILE
else
    echo "Recording failed"
    rm -f $TEMP_FILE
    exit 1
fi

