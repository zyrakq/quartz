#!/bin/bash

# Source directory path
source_dir="$1"
target_dir="$2"

# Check for missing arguments
if [ -z "$source_dir" ] || [ -z "$target_dir" ]; then
    echo "Please specify paths to source and target directories."
    exit 1
fi

# Function to check metadata of a file
check_metadata() {
    local file="$1"
    local publish=false

    # Read the contents of the file
    content=$(cat "$file")

    # Search for "publish: true"
    if grep -q "publish: true" <<< "$content"; then
        echo "true"
        return 0
    fi

    echo "false"
    return 1
}

# Main loop to find files
find "$source_dir" -type f -name "*.md" | while read -r file; do
    result=$(check_metadata "$file")
    if [ "$result" = "true" ]; then
        relative_path=$(realpath --relative-to="$source_dir" "$file")
        target_path="${target_dir}/${relative_path}"
        mkdir -p "$(dirname "$target_path")"
        cp "$file" "$target_path"
        echo "Copying $file to $target_path"
    else
        echo "Skipping $file"
    fi
done

echo "Copy completed."
