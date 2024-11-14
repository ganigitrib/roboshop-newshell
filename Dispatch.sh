#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default

# Define application name and log file path
app_name="dispatch"
log_file="/tmp/dispatch_install.log"
rm -f "$log_file"  # Remove the previous log file to start fresh

# Function to display headings and log them
print_heading() {
    echo -e "${COLOR}$1${NO_COLOR}"
    echo "$1" >> "$log_file"
}

echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

# Define app_prerequisites function with error handling
app_prerequisites() {
    print_heading "Create Application User"
    if ! id roboshop &>/dev/null; then
        useradd roboshop &>>"$log_file"
    fi
    if [ $? -ne 0 ]; then
        echo "Error: Could not create user 'roboshop' or user already exists" &>>"$log_file"
    fi

    print_heading "Create Application Directory"
    rm -rf /app &>>"$log_file"
    mkdir /app &>>"$log_file"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory /app" &>>"$log_file"
        exit 1
    fi

    print_heading "Download Application content"
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip &>>"$log_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download application content" &>>"$log_file"
        exit 1
    fi

    print_heading "Extract Application content"
    cd /app || exit 1
    unzip /tmp/${app_name}.zip &>>"$log_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to extract application content" &>>"$log_file"
        exit 1
    fi
}

# Run app prerequisites
app_prerequisites

# Copy the Dispatch service file to systemd directory
print_heading "Copy Dispatch service file"
if [ -f "Dispatch.service" ]; then
    sudo cp Dispatch.service /etc/systemd/system/dispatch.service &>>"$log_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to copy service file" &>>"$log_file"
        exit 1
    fi
else
    echo "Error: Dispatch.service file not found" &>>"$log_file"
    exit 1
fi

# Install Go Language
print_heading "Install Go Language"
dnf install -y golang &>>"$log_file"
if [ $? -ne 0 ]; then
    echo "Error: Failed to install Go language" &>>"$log_file"
    exit 1
fi

# Build the application
print_heading "Build Application"
cd /app || exit 1
go mod init "$app_name" &>>"$log_file"
go get &>>"$log_file"
go build &>>"$log_file"
if [ $? -ne 0 ]; then
    echo "Error: Failed to build application" &>>"$log_file"
    exit 1
fi

# Start and enable the Dispatch service
print_heading "Start Application Service"
sudo systemctl daemon-reload &>>"$log_file"
sudo systemctl enable dispatch &>>"$log_file"
sudo systemctl restart dispatch &>>"$log_file"
if [ $? -ne 0 ]; then
    echo "Error: Failed to start dispatch service" &>>"$log_file"
    exit 1
fi

echo "Application setup completed successfully."
