source /path/to/common.sh

echo -e "${COLOR}Copy Dispatch service file${NO_COLOR}"
cp Dispatch.service /etc/systemd/system/dispatch.service

echo -e "${COLOR}Install Golang${NO_COLOR}"
dnf install golang -y

echo -e "${COLOR}Add Application User${NO_COLOR}"
useradd roboshop

echo -e "${COLOR}Create Application Directory${NO_COLOR}"
rm -rf /app
mkdir /app

echo -e "${COLOR}Download Application Content${NO_COLOR}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
Cd /app

echo -e "${COLOR}Extract Application Content${NO_COLOR}"
unzip /tmp/dispatch.zip

echo -e "${COLOR}Copy Download Application Dependencies${NO_COLOR}"
go mod init dispatch
go get
go build

echo -e "${COLOR}Start Application Dependencies${NO_COLOR}"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
