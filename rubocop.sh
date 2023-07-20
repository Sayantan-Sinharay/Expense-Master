#!/bin/bash

# Check if the user provided the string to add as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <string_to_add>"
  exit 1
fi

string_to_add="$1"
directory="./" # Replace this with the path to your target directory

# Check if the target directory exists
if [ ! -d "$directory" ]; then
  echo "Directory not found: $directory"
  exit 1
fi

# Find all .rb files in the directory and its subdirectories
rb_files=$(find "$directory" -type f -name "*.rb")

# Loop through each .rb file and add the string at the top of the file
for file in $rb_files; do
  # Use sed to insert the string at the beginning of the file
  sed -i "1i\\$string_to_add" "$file"
done

echo "String '$string_to_add' added to the top of all .rb files in $directory and its subdirectories."
