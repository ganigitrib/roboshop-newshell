#!/bin/bash

# Source the common functions and variables
source /path/to/common.sh  # Update to the correct path for common.sh

# Define color to use for printing messages (update based on common.sh)
COLOR="$COLOR_PURPLE"  # Choose COLOR_PURPLE or COLOR_YELLOW from common.sh

# Copy Dispatch service file
echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service

# Install Golang
print_message "$COLOR" "Install Golang"
install_package "golang"  # Use install_package function from common.sh

# Add Application User
print_message "$COLOR" "Add Application User"
create_user "roboshop"  # Use create_user function from common.sh

# Create Application Directory
print_message "$COLOR" "Create Application Directory"
create_directory "/app"  # Use create_directory function from common.sh

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
manage_service "dispatch"  # Use manage_service function from common.sh
