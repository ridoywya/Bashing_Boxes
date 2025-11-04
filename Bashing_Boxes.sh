#!/bin/bash
# Bashing Boxes – Part 2: Storage_Boxes

# -------------------------------
#  INITIAL SETUP
# -------------------------------

# Ensure "data/" folder exists (for saved boxes)
[ ! -d "data" ] && mkdir data

# Default array of items
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
)

# -------------------------------
#  CORE FUNCTIONS 
# -------------------------------

# Print the entire list
print_list() {
    echo -e "\n--- Current Object List ---"
    if [ "${#OBJECTS[@]}" -eq 0 ]; then
        echo "The list is currently empty."
    else
        for i in "${!OBJECTS[@]}"; do
            echo "$((i+1)). ${OBJECTS[$i]}"
        done
    fi
    echo "---------------------------"
}

# Print item at a specific position
print_item_at_position() {
    read -p "Enter the position number: " pos
    index=$((pos - 1))
    if [ $index -ge 0 ] && [ $index -lt ${#OBJECTS[@]} ]; then
        echo "Item at position $pos: ${OBJECTS[$index]}"
    else
        echo "[ERROR] Invalid position number."
    fi
}

# Add new item
add_item() {
    read -p "Enter the name of the item to add: " item
    OBJECTS+=("$item")
    echo "\"$item\" has been added to the list."
}

# Remove last item
remove_last_item() {
    if [ ${#OBJECTS[@]} -gt 0 ]; then
        removed="${OBJECTS[-1]}"
        unset 'OBJECTS[-1]'
        echo "\"$removed\" has been removed from the list."
    else
        echo "[ERROR] The list is already empty."
    fi
}

# Remove item from a specific position
remove_item_from_position() {
    read -p "Enter the position number to remove: " pos
    index=$((pos - 1))
    if [ $index -ge 0 ] && [ $index -lt ${#OBJECTS[@]} ]; then
        removed="${OBJECTS[$index]}"
        unset 'OBJECTS[index]'
        OBJECTS=("${OBJECTS[@]}") # reindex array
        echo "\"$removed\" has been removed from position $pos."
    else
        echo "[ERROR] Invalid position number."
    fi
}

# -------------------------------
#  SAVE / LOAD FUNCTIONS
# -------------------------------

# Save the current box to a file
save_box() {
    [ ! -d "data" ] && mkdir data
    read -p "Enter a name for your box: " filename
    filepath="data/${filename}.txt"

    printf "%s\n" "${OBJECTS[@]}" > "$filepath"
    echo "✅ Box saved as '$filepath'."
}

# Load a previously saved box
load_box() {
    [ ! -d "data" ] && mkdir data
    echo -e "\n--- Available Saved Boxes ---"
    ls data/*.txt 2>/dev/null | sed 's/data\///; s/.txt//' || echo "No saved boxes found."
    echo "-------------------------------"

    read -p "Enter the name of the box to load: " filename
    filepath="data/${filename}.txt"

    if [ -f "$filepath" ]; then
        mapfile -t OBJECTS < "$filepath"
        echo "✅ Box '$filename' loaded successfully!"
    else
        echo "[ERROR] Box '$filename' does not exist."
    fi
}

# List all saved boxes
list_saved_boxes() {
    [ ! -d "data" ] && mkdir data
    echo -e "\n--- Saved Boxes ---"
    ls data/*.txt 2>/dev/null | sed 's/data\///; s/.txt//' || echo "No saved boxes found."
    echo "--------------------"
}

# Delete a saved box (optional stretch)
delete_box() {
    list_saved_boxes
    read -p "Enter the name of the box to delete: " filename
    filepath="data/${filename}.txt"
    if [ -f "$filepath" ]; then
        rm "$filepath"
        echo "🗑️ Box '$filename' deleted."
    else
        echo "[ERROR] That box doesn't exist."
    fi
}

# -------------------------------
# 🚪 EXIT FUNCTION
# -------------------------------

exit_script() {
    read -p "Would you like to save before exiting? (y/n): " answer
    if [[ $answer == [Yy] ]]; then
        save_box
    fi
    echo -e "\nExiting Bashing Boxes. Goodbye!\n"
    exit 0
}

# -------------------------------
#  MENU DISPLAY
# -------------------------------

display_menu() {
    echo "======================================"
    echo "        BASHING BOXES MENU"
    echo "======================================"
    echo "1. Print list"
    echo "2. Print item at X position"
    echo "3. Add item to list"
    echo "4. Remove last item"
    echo "5. Remove item at X position"
    echo "6. Exit"
    echo "7. Save current box"
    echo "8. Load saved box"
    echo "9. List saved boxes"
    echo "10. Delete a saved box"
    echo "======================================"
}

# -------------------------------
#  MAIN LOOP
# -------------------------------

while true; do
    display_menu
    read -p "Enter your choice (1-10): " choice
    case $choice in
        1) print_list ;;
        2) print_item_at_position ;;
        3) add_item ;;
        4) remove_last_item ;;
        5) remove_item_from_position ;;
        6) exit_script ;;
        7) save_box ;;
        8) load_box ;;
        9) list_saved_boxes ;;
        10) delete_box ;;
        *) echo -e "\n[ERROR] Invalid choice. Please select 1–10.\n" ;;
    esac
done
