Color="\e[35m
no_color=\e[0m"
echo -e "$color copy Dispatch service file $no_color"
cp Dispatch.service /etc/systemd/system/dispatch.service

echo -e "$Color install Golang $no_color"
 dnf install golang -y
echo -e "$color add Application User $no_color"
 useradd roboshop

 echo -e "$Color Create Application Directory $no_color"
 rm -rf /app
 mkdir /app


echo -e "$Color Download Application Content $no_color"
 curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
 cd /app

 echo -e "$Color Extract Application Content $no_color"
 unzip /tmp/dispatch.zip

echo -e "$Color Copy Download Application Dependencies $no_color"
go mod init dispatch
go get
go build

echo -e "$Color Start Application Dependencies $no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch