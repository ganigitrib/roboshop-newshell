#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default
app_name=Payment
echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/common.sh

echo -e "${COLOR}Copy Payment service file${NO_COLOR}"
cp Payment.service /etc/systemd/system/payment.service

echo -e "${COLOR}Install Python3 and required packages${NO_COLOR}"
dnf install python3 gcc python3-devel unzip -y

app_prerequisites

echo -e "${COLOR}Download Application Dependencies${NO_COLOR}"
pip3 install -r requirements.txt

echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
