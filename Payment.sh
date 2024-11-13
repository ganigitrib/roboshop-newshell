#!/bin/bash

# Define color variables
# shellcheck disable=SC2034
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default
app_name=Payment


echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

# shellcheck disable=SC2154
echo -e "$color Copy Payment Service file $no_color"
cp Payment.service /etc/systemd/system/payment.service
echo $?  # Check if the copy was successful

app_prerequisites
echo $? # Check if the prerequisites installation was successful

cd /app

echo -e "$color Download Application Dependencies $no_color"
pip3 install -r requirements.txt
echo $?  # Check if the dependencies installation was successful

echo -e "$color Start Application Service $no_color"
systemctl daemon-reload
echo $?  # Check if the daemon-reload was successful
systemctl enable payment
echo $?  # Check if enabling the service was successful
systemctl restart payment
echo $?  # Check if restarting the service was successful
