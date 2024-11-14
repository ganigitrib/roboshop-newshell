#!/bin/bash

# Define color variables
COLOR="\e[32m"          # Green color
NO_COLOR="\e[0m"        # Reset color

# Define log file
log_file="/tmp/app_install.log"
rm -f "$log_file"       # Remove log file if it exists to start fresh

# Define the function for printing headings
print_heading() {
    echo -e "${COLOR}$1${NO_COLOR}"   # Display the message with color
    echo -e "$1" &>>"$log_file"       # Log the message without color formatting
}

app_prerequisites() {
    print_heading "Create Application User"
    useradd roboshop &>>"$log_file"
    echo $?

    print_heading "Create Application Directory"
    rm -rf /app &>>"$log_file"
    mkdir /app &>>"$log_file"
    echo $?

    print_heading "Download Application content"
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip &>>"$log_file"
    echo $?

    print_heading "Extract Application content"
    cd /app || exit 1  # Ensure we’re in /app; exit with error if cd fails
    unzip /tmp/${app_name}.zip &>>"$log_file"
    echo $?
}

# Call the app_prerequisites function
app_prerequisites
