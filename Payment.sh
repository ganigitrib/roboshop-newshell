#!/bin/bash
echo "Sourcing common.sh"
source /home/ec2-user/roboshop-newshell/common.sh


echo -e "${COLOR}Copy Payment service file${NO_COLOR}"
cp Payment.service /etc/systemd/system/payment.service


echo -e "${COLOR}Install Python3 and required packages${NO_COLOR}"
dnf install python3 gcc python3-devel unzip -y


echo -e "${COLOR}Create Application User${NO_COLOR}"
useradd roboshop


echo -e "${COLOR}Create Application Directory${NO_COLOR}"
rm -rf /app
mkdir /app


echo -e "${COLOR}Download Application content${NO_COLOR}"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app


echo -e "${COLOR}Extract Application content${NO_COLOR}"
unzip /tmp/payment.zip


echo -e "${COLOR}Download Application Dependencies${NO_COLOR}"
pip3 install -r requirements.txt


echo -e "${COLOR}Start Application Service${NO_COLOR}"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
