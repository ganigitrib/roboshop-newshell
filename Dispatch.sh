#!/bin/bash

# Ensure common.sh is sourced with the absolute path
source /home/ec2-user/roboshop-newshell/common.sh

# Printing messages with color
print_message "Copy Dispatch service file"
cp Dispatch.service /etc/systemd/system/dispatch.service

print_message "Install Golang"
dnf install golang -y

print_message "Add Application User"
useradd roboshop

print_message "Create Application Directory"
rm -rf /app
mkdir /app

print_message "Download Application Content"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

print_message "Extract Application Content"
unzip /tmp/dispatch.zip

print_message "Copy Download Application Dependencies"
go mod init dispatch
go get
go build

print_message "Start Application Dependencies"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
