#!/bin/bash

# Define color variables
COLOR="\e[32m"          # Yellow color
NO_COLOR="\e[0m"        # Reset color

# Function to print messages in color
print_message() {
    echo -e "${COLOR}$1${NO_COLOR}"
}
