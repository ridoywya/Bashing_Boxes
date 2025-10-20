#!/bin/bash
# bashing_boxes.sh

# Array to hold 10 items
# NOTE: In a real scenario, you would manually generate 10 items from the URL:
# https://52prompts.com/random-object-generator/

OBJECTS=(
    "Crayons"
    "Toothbrush"
    "Pencil Case"
    "Towel"
    "Mug"
    "Laptop"
    "Umbrella"
    "Basket"
    "Key"
    "Remote Control"

# Function to print the entire list
print_list() {
    echo -e "\n--- Current Object List ---"
    if [ ${#OBJECTS[@]} -eq 0 ]; then
        echo "The list is currently empty."
        else
        # Print list with indices
        for i in "${!OBJECTS[@]}"; do
            # Indices are 0-based in Bash arrays, adding 1 for user readability
            echo "$((i+1)). ${OBJECTS[$i]}"
        done
    fi
    echo "---------------------------\n"} 
