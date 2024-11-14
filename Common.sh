#!/bin/bash

# Define color variables
COLOR="\e[32m"          # Green color
NO_COLOR="\e[0m"        # Reset color
rm -f $log_file

app_prerequisites() {
    echo -e "${COLOR}Create Application User${NO_COLOR}"
     useradd roboshop &>>$log_file
     echo $?

    echo -e "${COLOR}Create Application Directory${NO_COLOR}"
    rm -rf /app &>>$log_file
    mkdir /app &>>$log_file
    echo $?

    echo -e "${COLOR}Download Application content${NO_COLOR}"
    curl -L -o /tmp/${app_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${app_name}.zip &>>$log_file
    echo $?

     cd /app

    echo -e "${COLOR}Extract Application content${NO_COLOR}"
    cd /app
    unzip /tmp/${app_name}.zip &>>$log_file
    echo $?
}
