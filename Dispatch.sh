#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default

echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/common.sh

echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service

echo -e "${COLOR}Install Go Language${NO_COLOR}"
dnf install golang -y

echo -e "${COLOR}Create Application User${NO_COLOR}"
useradd roboshop

echo -e "${COLOR}Create Application Directory${NO_COLOR}"
rm -rf /app
mkdir /app

echo -e "${COLOR}Download Application content${NO_COLOR}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "${COLOR}Extract Application content${NO_COLOR}"
unzip /tmp/dispatch.zip

echo -e "${COLOR}Build Application${NO_COLOR}"
go mod init dispatch
go get
go build

echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
