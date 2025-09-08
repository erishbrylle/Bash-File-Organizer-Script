#!/bin/bash
# ===============================================
# File Organizer Script
# Author: Erish Brylle
# Description: Automatically sorts files in a given
#              directory into subfolders by extension.
# ===============================================

# Directory to organize (default = current directory)
TARGET_DIR="${1:-.}"

# Create an "Organized" folder inside target directory
ORG_DIR="$TARGET_DIR/Organized"
mkdir -p "$ORG_DIR"

# Loop through all files in the target directory
for file in "$TARGET_DIR"/*; do
    # Skip if it's a directory
    [ -d "$file" ] && continue

    # Extract filename and extension
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]') # lowercase

    # If file has no extension, label it "noext"
    if [ "$filename" = "$extension" ]; then
        extension="noext"
    fi

    # Create a folder for this extension if it doesn’t exist
    mkdir -p "$ORG_DIR/$extension"

    # Move file into its folder
    mv "$file" "$ORG_DIR/$extension/"
    echo "Moved: $filename -> $ORG_DIR/$extension/"
done

echo "✅ Files have been organized inside: $ORG_DIR"