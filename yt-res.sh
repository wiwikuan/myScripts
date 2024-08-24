#!/bin/bash

# Check if two arguments are provided.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <resolution> <url>"
    exit 1
fi

# Define the resolution to be used in the download.
resolution=$1

# Define the URL from which the video should be downloaded.
url=$2

# Use yt-dlp to download a video with the specified resolution.
yt-dlp -f "bestvideo[height<=${resolution}]+bestaudio/best[height<=${resolution}]" $url
