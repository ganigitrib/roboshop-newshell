#!/bin/bash

# Ensure the common.sh file is present
echo "Sourcing common.sh"
if [ -f common.sh ]; then
  source common.sh
  echo $?
else
  echo "common.sh not found. Exiting."
  exit 1
fi

# Ensure the Payment service file is present
echo "Copy Payment service file"
SERVICE_FILE_PATH="/path/to/Payment.service"
if [ -f "$SERVICE_FILE_PATH" ]; then
  cp $SERVICE_FILE_PATH /etc/systemd/system/Payment.service
  echo $?
else
  echo "Payment.service file not found at $SERVICE_FILE_PATH. Exiting."
  exit 1
fi

# Install Python3 and required packages
echo "Install Python3 and required packages"
yum install -y python3 gcc python3-devel unzip
echo $?

# Create Application User
echo "Create Application User"
id roboshop &>/dev/null
if [ $? -ne 0 ]; then
  useradd roboshop
  echo $?
else
  echo "User 'roboshop' already exists"
fi

# Create Application Directory
echo "Create Application Directory"
mkdir -p /home/roboshop/payment
echo $?
Cd /Home/Roboshop/Payment
echo $?

# Download Application content
echo "Download Application content"
ZIP_URL="https://example.com/Payment.zip"
curl -L -o /tmp/Payment.zip $ZIP_URL
echo $?

# Check if the downloaded zip file is valid
if unzip -t /tmp/Payment.zip; then
  unzip /tmp/Payment.zip
  echo $?
else
  echo "Error: Invalid zip file. Exiting."
  exit 1
fi

# Download Application Dependencies
echo "Download Application Dependencies"
if [ -f requirements.txt ]; then
  pip3 install -r requirements.txt
  echo $?
else
  echo "Error: requirements.txt not found. Exiting."
  exit 1
fi

# Start Application Service
echo "Start Application Service"
systemctl daemon-reload
echo $?
systemctl enable Payment
echo $?
systemctl start Payment
echo $?
