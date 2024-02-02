#!/bin/sh

# Function to execute the command and capture the exit code
execute_command() {
    local directory="$1"
    if [ -f "$directory/Chart.yaml" ]; then
        helm lint "$directory"
        local exit_code=$?
    else
        echo "==> Skipping $directory (no Chart.yaml found)"
        local exit_code=0
    fi
    #echo "Exit code for '$directory': $exit_code"
    return $exit_code
}

# Check if a path is provided as a parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <parent_directory>"
    exit 1
fi

parent_directory="$1"

# Loop through all subdirectories
for directory in "$parent_directory"/*/; do
    # Exclude the parent directory itself
    if [ -d "$directory" ]; then
        execute_command "$directory"
        exit_code=$?
        # Exit the script if exit code is not 0
        if [ $exit_code -ne 0 ]; then
            exit $exit_code
        fi
    fi
done

echo -e "\nAll commands executed successfully."
