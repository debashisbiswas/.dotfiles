#!/usr/bin/env bash

echo "Recording started. Press 'q' to stop and transcribe..."

# Run ffmpeg in foreground so it can receive 'q' input
ffmpeg -f pulse -i default /tmp/voice.wav
FFMPEG_EXIT_CODE=$?

# Only proceed with transcription if recording completed successfully
if [ $FFMPEG_EXIT_CODE -eq 0 ] || [ $FFMPEG_EXIT_CODE -eq 255 ]; then
    echo "Transcribing..."
    curl https://vale.queue-mixolydian.ts.net/inference \
          -H "Content-Type: multipart/form-data" \
          -F file="@/tmp/voice.wav" \
          -F temperature="0.0" \
          -F temperature_inc="0.2" \
          -F response_format="text"
    rm /tmp/voice.wav
else
    echo "Recording failed"
    rm -f /tmp/voice.wav
    exit 1
fi
