#!/bin/bash

# Define color variables
COLOR='\e[1;32m'  # Green color for messages
NO_COLOR='\e[0m'  # Reset color to default
app_name=dispatch
echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/Common.sh

echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

echo -e "${COLOR}Install Go Language${NO_COLOR}"
dnf install golang -y &>>$log_file
echo $?

app_prerequisites

echo -e "${COLOR}Build Application${NO_COLOR}"
go mod init dispatch
go get &>>$log_file
go build &>>$log_file
echo $?

echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file
echo $?
