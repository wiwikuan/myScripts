#!/bin/bash

generate_story() {
    local model=$1
    local prompt="Write a long nonsensical story."
    ollama run "$model" "$prompt"
}

save_story() {
    local story=$1
    local index=$2
    local filename="nonsense_story_$index.txt"
    echo "$story" > "$filename"
    echo "Saved story to $filename"
}

print_usage() {
    echo "Usage: $0 <number_of_stories> <model>"
    echo "Example: $0 5 llama2"
}

if [ $# -ne 2 ]; then
    print_usage
    exit 1
fi

num_stories=$1
model=$2

if ! [[ "$num_stories" =~ ^[0-9]+$ ]]; then
    echo "Error: Number of stories must be a positive integer."
    print_usage
    exit 1
fi

echo "Generating $num_stories nonsense stories using the $model model..."

for i in $(seq 1 $num_stories); do
    echo -e "\nGenerating story $i..."
    story=$(generate_story "$model")
    save_story "$story" "$i"
done

echo -e "\nAll stories generated and saved!"
