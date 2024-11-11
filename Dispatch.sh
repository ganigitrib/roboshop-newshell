#!/bin/bash

# Source the common functions and variables
source /home/ec2-user/roboshop-newshell/common.sh  # Replace with the actual path


# Define color to use for printing messages
COLOR="$COLOR_PURPLE"

# Copy Dispatch service file
print_message "$COLOR" "Copy Dispatch service file"
cp Dispatch.service /etc/systemd/system/dispatch.service

# Install Golang
print_message "$COLOR" "Install Golang"
install_package "golang"

# Add Application User
print_message "$COLOR" "Add Application User"
create_user "roboshop"

# Create Application Directory
print_message "$COLOR" "Create Application Directory"
create_directory "/app"

# Download Application Content
print_message "$COLOR" "Download Application Content"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip

# Navigate to Application Directory
cd /app

# Extract Application Content
print_message "$COLOR" "Extract Application Content"
unzip -o /tmp/dispatch.zip

# Download and Build Application Dependencies
print_message "$COLOR" "Download Application Dependencies"
go mod init dispatch
go get
go build

# Start Application Service
print_message "$COLOR" "Start Application Service"
manage_service "dispatch"
