echo -e "\e[35m copy Dispatch service file \e[0m"
cp Dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[35m install Golang \e[0m"
 dnf install golang -y
echo -e "\e[35m add Application User \e[0m"
 useradd roboshop

 echo -e "\e[35m Create Application Directory \e[0m"
 rm -rf /app
 mkdir /app


echo -e "\e[35m Download Application Content \e[0m"
 curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
 cd /app

 echo -e "\e[35m Extract Application Content \e[0m"
 unzip /tmp/dispatch.zip

echo -e "\e[35m Copy Download Application Dependencies \e[0m"
go mod init dispatch
go get
go build

echo -e "\e[35m Start Application Dependencies \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch