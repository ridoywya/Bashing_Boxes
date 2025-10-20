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
    exit_script() { 
    echo -e "\nExiting Bashing Boxes.Goodbye!\n"
    exit 0 } 
    
    # Function to display the menu
display_menu() {
    echo "======================================"
    echo "        BASHING BOXES MENU"
    echo "======================================"
    echo "1. Print list"
    echo "2. Print item at X position in list"
    echo "3. Add item to list"
    echo "4. Remove last item from list"
    echo "5. Remove item from X position"
    echo "6. Exit"
    echo "======================================"
}

# Main script logic
while true; do
    display_menu
    read -p "Enter your choice (1-6): " choice
    
    case $choice in
        1)
            print_list
            ;;
        2)
            print_item_at_position
            ;;
        3)
            add_item
            ;;
        4)
            remove_last_item
            ;;
        5)
            remove_item_from_position
            ;;
        6)
            exit_script
            ;;
        *)
            echo -e "\n[ERROR] Invalid choice. Please select 1 through 6.\n"
            ;;
    esac
done
