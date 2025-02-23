#!/bin/bash
host=$(hostname)

# Function to display CPU usage
get_cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
}

# Function to display memory usage
get_memory_usage() {
    echo -e "\nMemory Usage:"
    free -m | awk 'NR==2 {printf "Used: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2}'
}

# Function to display disk usage
get_disk_usage() {
    echo -e "\nDisk Usage:"
    df -h | awk '{if ($6 == "/") {print "Root: " $3 " used out of " $2 " (" $5 ")"}}'
}

# Main loop to display resource usage in real time
main() {
    clear  # Clear the screen before starting
    while true; do
        echo "==============================================="
        echo "   Real-Time Resource Monitor of $host     "
        echo "==============================================="

        # Display CPU, Memory, and Disk usage
        get_cpu_usage
        get_memory_usage
        get_disk_usage

        echo -e "\nPress Ctrl+C to exit..."
        echo "==================================="

        sleep 3  # Wait for 3 seconds before refreshing
        clear    # Clear the screen for the next update
    done
}

# Run the main function
main
