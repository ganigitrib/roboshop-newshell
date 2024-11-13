#!/bin/bash

# Define color variables
COLOR="\e[32m"          # Green color
NO_COLOR="\e[0m"        # Reset color

# Function to print messages in color
print_message() {
    echo -e "${COLOR}$1${NO_COLOR}"
}

app_prerequisites() {
    echo -e "${COLOR}Create Application User${NO_COLOR}"
    # Add user only if it does not exist
    id -u roboshop &>/dev/null || useradd roboshop
    echo $?  # Output the exit code to confirm success

    echo -e "${COLOR}Create Application Directory${NO_COLOR}"
    rm -rf /app
    mkdir /app
    echo $?  # Output the exit code to confirm success

    echo -e "${COLOR}Download Application content${NO_COLOR}"
    # Check if app_name is set before downloading
    if [ -z "$app_name" ]; then
        echo -e "${COLOR}Error: app_name variable is not set.${NO_COLOR}"
        exit 1
    fi
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip
    echo $?  # Output the exit code to confirm success

    echo -e "${COLOR}Extract Application content${NO_COLOR}"
    # Check if the downloaded file is a valid ZIP before extracting
    if file /tmp/${app_name}.zip | grep -q 'Zip archive data'; then
        cd /app
        unzip /tmp/${app_name}.zip
        echo $?  # Output the exit code to confirm success
    else
        echo -e "${COLOR}Error: Downloaded file is not a valid zip archive.${NO_COLOR}"
        exit 1
    fi
}
