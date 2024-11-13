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
    id -u roboshop &>/dev/null || useradd roboshop  # Check if user exists before adding

    echo -e "${COLOR}Create Application Directory${NO_COLOR}"
    rm -rf /app
    mkdir /app

    echo -e "${COLOR}Download Application content${NO_COLOR}"
    if [ -z "$app_name" ]; then
        echo -e "${COLOR}Error: app_name variable is not set.${NO_COLOR}"
        exit 1
    fi
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip

    echo -e "${COLOR}Extract Application content${NO_COLOR}"
    cd /app
    unzip /tmp/${app_name}.zip
}
