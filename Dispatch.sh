#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default
app_name=dispatch
echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service
echo $?

echo -e "${COLOR}Install Go Language${NO_COLOR}"
dnf install golang -y
echo $?

app_prerequisites

echo -e "${COLOR}Build Application${NO_COLOR}"
go mod init dispatch
go get
go build
echo $?

echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
echo $?
