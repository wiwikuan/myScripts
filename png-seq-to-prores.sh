#!/bin/bash

# Check if an output filename was provided
if [ $# -eq 0 ]; then
    echo "Error: No output filename provided"
    echo "Usage: $0 <output_filename>"
    exit 1
fi

# Get the output filename from the first argument
output_file="$1"

# Check if the output filename ends with .mov, if not, append it
if [[ ! $output_file =~ \.mov$ ]]; then
    output_file="${output_file}.mov"
fi

# Run the FFmpeg command
ffmpeg -framerate 30 -i %06d.png -c:v prores_ks -profile:v 4444 -qscale:v 5 -vendor apl0 -pix_fmt yuva444p10le "$output_file"

# Check if FFmpeg command was successful
if [ $? -eq 0 ]; then
    echo "Conversion completed successfully. Output file: $output_file"
else
    echo "Error: FFmpeg command failed"
    exit 1
fi
