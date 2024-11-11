Source Common.sh

# Printing with colors
# shellcheck disable=SC2154
echo -e "${color}Copy Dispatch service file${no_color}"
cp Dispatch.service /etc/systemd/system/dispatch.service

echo -e "${color}Install Golang${no_color}"
dnf install golang -y

echo -e "${color}Add Application User${no_color}"
useradd roboshop

echo -e "${color}Create Application Directory${no_color}"
rm -rf /app
mkdir /app

echo -e "${color}Download Application Content${no_color}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "${color}Extract Application Content${no_color}"
unzip /tmp/dispatch.zip

echo -e "${color}Copy Download Application Dependencies${no_color}"
go mod init dispatch
go get
go build

echo -e "${color}Start Application Dependencies${no_color}"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
