#!/bin/bash

echo "Sourcing common.sh"
source common.sh
echo $?

echo "Copy Payment service file"
cp /path/to/Payment.service /etc/systemd/system/Payment.service
echo $?

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
cd /home/roboshop/payment
echo $?

# Download Application content
echo "Download Application content"
curl -L -o /tmp/Payment.zip https://example.com/Payment.zip
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
