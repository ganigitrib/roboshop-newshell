#!/bin/bash

source common.sh

# Assigning color variables
color='\033[0;32m'  # Green
no_color='\033[0m'  # No color

echo -e "${color}Copy Payment Service file${no_color}"
cp Payment.service /etc/systemd/system/payment.service
echo $?  # Check if the copy was successful

app_prerequisites
echo $?  # Check if the prerequisites installation was successful

echo -e "${color}Download Application content${no_color}"
ZIP_URL="https://example.com/Payment.zip"
curl -L -o /tmp/Payment.zip $ZIP_URL
echo $?  # Check if the download was successful

# Check if the downloaded zip file is valid
if unzip -t /tmp/Payment.zip; then
  unzip /tmp/Payment.zip
  echo $?  # Check if the unzipping was successful
else
  echo "Error: Invalid zip file. Exiting."
  exit 1
fi

echo -e "${color}Download Application Dependencies${no_color}"
if [ -f requirements.txt ]; then
  pip3 install -r requirements.txt
  echo $?  # Check if the dependencies installation was successful
else
  echo "Error: requirements.txt not found. Creating a basic requirements.txt file."
  # Create a basic requirements.txt file as a fallback
  echo "flask" > requirements.txt  # Adjust as needed
  pip3 install -r requirements.txt
  echo $?  # Check if the dependencies installation was successful
fi

echo -e "${color}Start Application Service${no_color}"
systemctl daemon-reload
echo $?  # Check if the daemon-reload was successful
systemctl enable payment
echo $?  # Check if enabling the service was successful
systemctl restart payment
echo $?  # Check if restarting the service was successful
