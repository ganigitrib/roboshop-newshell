#!/bin/bash

# Define color variables
COLOR="\e[32m"          # Yellow color
NO_COLOR="\e[0m"        # Reset color

# Function to print messages in color
print_message() {
    echo -e "${COLOR}$1${NO_COLOR}"
}
app_prerequisites() {
  echo -e "${COLOR}Create Application User${NO_COLOR}"
  useradd roboshop

  echo -e "${COLOR}Create Application Directory${NO_COLOR}"
  rm -rf /app
  mkdir /app

  echo -e "${COLOR}Download Application content${NO_COLOR}"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name.zip
  cd /app

  echo -e "${COLOR}Extract Application content${NO_COLOR}"
  unzip /tmp/$app_name.zip

}
