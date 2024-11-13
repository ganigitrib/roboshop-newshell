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
    id -u roboshop &>/dev/null || useradd roboshop
    echo $?

    echo -e "${COLOR}Create Application Directory${NO_COLOR}"
    rm -rf /app
    mkdir /app
    echo $?

    echo -e "${COLOR}Download Application content${NO_COLOR}"
    if [ -z "$app_name" ]; then
        echo -e "${COLOR}Error: app_name variable is not set.${NO_COLOR}"
        exit 1
    fi

    # Download application content and check if successful
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip
    if [ $? -ne 0 ] || [ ! -s /tmp/${app_name}.zip ]; then
        echo -e "${COLOR}Error: Failed to download ${app_name}.zip or file is empty.${NO_COLOR}"
        exit 1
    fi

    echo -e "${COLOR}Extract Application content${NO_COLOR}"
    if file /tmp/${app_name}.zip | grep -q 'Zip archive data'; then
        cd /app
        unzip /tmp/${app_name}.zip
        echo $?
    else
        echo -e "${COLOR}Error: Downloaded file is not a valid zip archive.${NO_COLOR}"
        exit 1
    fi
}
