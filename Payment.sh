#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default

# Define the application name
app_name=Payment

echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/common.sh

# Copy the Payment service file to systemd directory
echo -e "${COLOR}Copy Payment service file${NO_COLOR}"
cp Payment.service /etc/systemd/system/payment.service

# Install Python3 and required packages
echo -e "${COLOR}Install Python3 and required packages${NO_COLOR}"
dnf install -y python3 gcc python3-devel unzip

# Run the app prerequisites defined in common.sh
app_prerequisites

# Install the application dependencies from requirements.txt
echo -e "${COLOR}Download Application Dependencies${NO_COLOR}"
if [ -f "/app/requirements.txt" ]; then
    pip3 install -r /app/requirements.txt
else
    echo -e "${COLOR}Error: requirements.txt not found in /app${NO_COLOR}"
    exit 1
fi

# Start and enable the Payment service
echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
