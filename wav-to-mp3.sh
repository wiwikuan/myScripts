#!/bin/bash
# This script converts WAV files to MP3 files at 160kbps
for file in *.wav; do
    [ -f "$file" ] || break # Break if no more wav files are found
    ffmpeg -i "${file}" -codec:a libmp3lame -b:a 160k "${file%.wav}.mp3"
done
