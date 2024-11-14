#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default

# Define application name and log file path
app_name="Dispatch"
log_file="/tmp/Dispatch_install.log"
rm -f "$log_file"  # Remove log file if it exists to start fresh

# Function to print heading messages
print_heading() {
    echo -e "${COLOR}$1${NO_COLOR}"  # Print heading in color
    echo "$1" &>>"$log_file"         # Log the message to the log file without color formatting
}

echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

# Copy the Dispatch service file to the systemd directory
print_heading "Copy Dispatch service file"
cp Dispatch.service /etc/systemd/system/dispatch.service &>>"$log_file"
echo $? &>>"$log_file"

# Install Go Language
print_heading "Install Go Language"
dnf install golang -y &>>"$log_file"
echo $? &>>"$log_file"

# Call the app_prerequisites function from Common.sh
app_prerequisites

# Build the application
print_heading "Build Application"
cd /app || exit 1  # Ensure we're in /app; exit if cd fails
go mod init "$app_name" &>>"$log_file"
echo $? &>>"$log_file"
go get &>>"$log_file"
echo $? &>>"$log_file"
go build &>>"$log_file"
echo $? &>>"$log_file"

# Start and enable the Dispatch service
print_heading "Start Application Service"
systemctl daemon-reload &>>"$log_file"
echo $? &>>"$log_file"
systemctl enable dispatch &>>"$log_file"
echo $? &>>"$log_file"
systemctl restart dispatch &>>"$log_file"
echo $? &>>"$log_file"
