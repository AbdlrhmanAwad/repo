#!/bin/bash

# Function to create a bash file
create_bashfile() {
    read -p "Enter the name of the bash file to create: " bashfilename
    if [ -f "$bashfilename" ]; then
        echo "File '$bashfilename' already exists."
    else
        touch "$bashfilename"
        chmod +x "$bashfilename"
        echo "#!/bin/bash" > "$bashfilename"
        echo "File '$bashfilename' created successfully."
    fi
}

# Function to create a file
create_file() {
    read -p "Enter the name of the file to create: " filename
    if [ -f "$filename" ]; then
        echo "File '$filename' already exists."
    else
        touch "$filename"
        echo "File '$filename' created successfully."
    fi
}

# Function to create a directory
create_directory() {
    read -p "Enter the name of the directory to create: " dirname
    if [ -d "$dirname" ]; then
        echo "Directory '$dirname' already exists."
    else
        mkdir "$dirname"
        echo "Directory '$dirname' created successfully."
    fi
}

# Function to copy a file or directory
copy_item() {
    read -p "Enter the path of the file/directory to copy: " src
    read -p "Enter the target path for the copy: " dest
    if [ ! -e "$src" ]; then
        echo "Source '$src' does not exist."
    else
        cp -r "$src" "$dest"
        echo "Copied '$src' to '$dest'."
    fi
}

# Function to move a file or directory
move_item() {
    read -p "Enter the path of the file/directory to move: " src
    read -p "Enter the target path for the move: " dest
    if [ ! -e "$src" ]; then
        echo "Source '$src' does not exist."
    else
        mv "$src" "$dest"
        echo "Moved '$src' to '$dest'."
    fi
}

# Function to rename a file or directory
rename_item() {
    read -p "Enter the current name of the file/directory: " old_name
    read -p "Enter the new name of the file/directory: " new_name
    if [ ! -e "$old_name" ]; then
        echo "Current item '$old_name' does not exist."
    else
        mv "$old_name" "$new_name"
        echo "Renamed '$old_name' to '$new_name'."
    fi
}

# Function to delete a file
delete_file() {
    read -p "Enter the name of the file to delete: " filename
    if [ ! -f "$filename" ]; then
        echo "File '$filename' does not exist."
    else
        read -p "Are you sure you want to delete '$filename'? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            rm "$filename"
            echo "File '$filename' deleted successfully."
        else
            echo "File deletion cancelled."
        fi
    fi
}

# Function to delete a directory
delete_directory() {
    read -p "Enter the name of the directory to delete: " dirname
    if [ ! -d "$dirname" ]; then
        echo "Directory '$dirname' does not exist."
    else
        read -p "Are you sure you want to delete '$dirname'? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            rm -r "$dirname"
            echo "Directory '$dirname' deleted successfully."
        else
            echo "Directory deletion cancelled."
        fi
    fi
}

# Function to search for files based on criteria
search_files() {
    read -p "Enter search directory (use . for current directory): " search_dir
    read -p "Enter file name pattern (e.g., *.txt): " file_name
    read -p "Enter minimum file size (e.g., +1M for files larger than 1MB, leave blank for no size filter): " file_size
    read -p "Enter modification date (e.g., 2023-01-01 for files modified after this date, leave blank for no date filter): " mod_date
    
    # Construct find command
    find_command="find \"$search_dir\" -type f"
    
    if [ -n "$file_name" ]; then
        find_command+=" -name \"$file_name\""
    fi
    if [ -n "$file_size" ]; then
        find_command+=" -size $file_size"
    fi
    if [ -n "$mod_date" ]; then
        find_command+=" -newermt \"$mod_date\""
    fi
    
    echo "Executing command: $find_command"
    eval "$find_command"
}

# Function to display system information
display_system_info() {
    echo "System Information:"
    uname -a
    hostname
    uptime
    date
}

# Function to display CPU usage
display_cpu_usage() {
    echo "CPU Usage:"
    mpstat 1 1 | awk '/Average/ {print "CPU Usage: " 100 - $12 "%"}'
}

# Function to display memory usage
display_memory_usage() {
    echo "Memory Usage:"
    free -h
}

# Function to display disk space usage
display_disk_space() {
    echo "Disk Space Usage:"
    df -h
}

# Function to change file permissions
change_permissions() {
    read -p "Enter the file or directory to modify permissions: " filepath
    read -p "Enter the permission mode (e.g., 755): " mode
    chmod "$mode" "$filepath"
    echo "Permissions for '$filepath' changed to $mode."
}

# Function to change file ownership
change_ownership() {
    read -p "Enter the file or directory to modify ownership: " filepath
    read -p "Enter the new owner (user:group): " owner
    chown "$owner" "$filepath"
    echo "Ownership of '$filepath' changed to $owner."
}

# Function to create a backup
create_backup() {
    read -p "Enter the file or directory to backup: " src
    read -p "Enter the backup file name (e.g., backup.tar.gz): " backup_file
    tar -czf "$backup_file" "$src"
    echo "Backup of '$src' created as '$backup_file'."
}

# Function to restore from a backup
restore_backup() {
    read -p "Enter the backup file name to restore: " backup_file
    read -p "Enter the target directory for restoration: " target_dir
    tar -xzf "$backup_file" -C "$target_dir"
    echo "Restored '$backup_file' to '$target_dir'."
}

# Function to generate a summary report
generate_report() {
    report_file="system_report_$(date +%Y%m%d_%H%M%S).txt"
    {
        echo "System Report - $(date)"
        echo "---------------------"
        uname -a
        hostname
        uptime
        date
        echo
        echo "CPU Usage:"
        mpstat 1 1 | awk '/Average/ {print "CPU Usage: " 100 - $12 "%"}'
        echo
        echo "Memory Usage:"
        free -h
        echo
        echo "Disk Space Usage:"
        df -h
    } > "$report_file"
    echo "Report generated and saved to '$report_file'."
}

# Interactive menu for file and directory operations
file_operations_menu() {
    PS3="Select a file operation: "
    options=("Create Bash File" "Create File" "Create Directory" "Copy Item" "Move Item" "Rename Item" "Delete File" "Delete Directory" "Change Permissions" "Change Ownership" "Backup File/Directory" "Restore Backup" "Return to Main Menu")
    select opt in "${options[@]}"
    do
        case $opt in
            "Create Bash File")
                create_bashfile
                ;;
            "Create File")
                create_file
                ;;
            "Create Directory")
                create_directory
                ;;
            "Copy Item")
                copy_item
                ;;
            "Move Item")
                move_item
                ;;
            "Rename Item")
                rename_item
                ;;
            "Delete File")
                delete_file
                ;;
            "Delete Directory")
                delete_directory
                ;;
            "Change Permissions")
                change_permissions
                ;;
            "Change Ownership")
                change_ownership
                ;;
            "Backup File/Directory")
                create_backup
                ;;
            "Restore Backup")
                restore_backup
                ;;
            "Return to Main Menu")
                break
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

# Interactive menu for system monitoring
system_monitoring_menu() {
    PS3="Select a system monitoring option: "
    options=("Display System Information" "Display CPU Usage" "Display Memory Usage" "Display Disk Space Usage" "Generate System Report" "Return to Main Menu")
    select opt in "${options[@]}"
    do
        case $opt in
            "Display System Information")
                display_system_info
                ;;
            "Display CPU Usage")
                display_cpu_usage
                ;;
            "Display Memory Usage")
                display_memory_usage
                ;;
            "Display Disk Space Usage")
                display_disk_space
                ;;
            "Generate System Report")
                generate_report
                ;;
            "Return to Main Menu")
                break
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

# Main interactive menu
main_menu() {
    PS3="Choose an option: "
    options=("File Operations" "System Monitoring" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "File Operations")
                file_operations_menu
                ;;
            "System Monitoring")
                system_monitoring_menu
                ;;
            "Quit")
                break
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

# Run the main menu
main_menu

