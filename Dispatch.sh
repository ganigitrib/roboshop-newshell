#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default

# Define application name and log file path
app_name="dispatch"
log_file="/tmp/dispatch_install.log"  # Ensure log_file is assigned

echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

# Copy the Dispatch service file to systemd directory
echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service &>>"$log_file"
echo $?

# Install Go Language
echo -e "${COLOR}Install Go Language${NO_COLOR}"
dnf install golang -y &>>"$log_file"
echo $?

# Call the app_prerequisites function from Common.sh
app_prerequisites

# Build the application
echo -e "${COLOR}Build Application${NO_COLOR}"
go mod init "$app_name" &>>"$log_file"
go get &>>"$log_file"
go build &>>"$log_file"
echo $?

# Start and enable the Dispatch service
echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload &>>"$log_file"
systemctl enable dispatch &>>"$log_file"
systemctl restart dispatch &>>"$log_file"
echo $?