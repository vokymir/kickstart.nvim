#!/bin/bash

# You can pass a target directory as an argument, defaults to current directory (.)
TARGET_DIR="${1:-.}"
OUTPUT_FILE="combined_texts.txt"

# Empty the output file if it already exists so we don't duplicate data on multiple runs
> "$OUTPUT_FILE"

echo "Scanning $TARGET_DIR for text files..."

# Use find to get all non-hidden files
# -type f        : files only
# -not -path '*/\.*' : ignore hidden directories and files (e.g., .git, .env)
# -print0        : separates filenames with null characters to safely handle spaces
find "$TARGET_DIR" -type f -not -path '*/\.*' -print0 | while IFS= read -r -d '' file; do
    
    # Skip the output file itself to prevent an infinite loop
    if [[ "$file" == "./$OUTPUT_FILE" || "$file" == "$OUTPUT_FILE" || "$file" == "$TARGET_DIR/$OUTPUT_FILE" ]]; then
        continue
    fi

    # Check if the file is a text file (ignores binaries like images, PDFs, etc.)
    if file --mime-type "$file" | grep -q "text/"; then
        # Write the header
        echo "####### $file #######" >> "$OUTPUT_FILE"
        
        # Append the file contents
        cat "$file" >> "$OUTPUT_FILE"
        
        # Add a couple of newlines for readability between files
        echo -e "\n\n" >> "$OUTPUT_FILE"
    fi
done

echo "Done! All text files have been combined into: $OUTPUT_FILE"
