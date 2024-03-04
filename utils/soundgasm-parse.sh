#!/bin/bash
# Get user input
read -p "Enter the URL: " url

# Curl the URL and Print
curl -s "$url" | grep -o 'm4a: "https://media.soundgasm.net/sounds/[^"]*"' | while read -r line; do
    sound_url=$(echo "$line" | grep -o 'https://[^"]*')
    echo "Direct Media Link: $sound_url"
done