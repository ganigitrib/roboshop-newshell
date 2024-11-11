source /path/to/common.sh

echo -e "${color}Copy Payment service file${no_color}"
cp Payment.service /etc/systemd/system/payment.service


echo -e "${color}Install Python3 and required packages${no_color}"
dnf install python3 gcc python3-devel unzip -y


echo -e "${color}Create Application User${no_color}"
useradd roboshop


echo -e "${color}Create Application Directory${no_color}"
rm -rf /app  # Remove if it exists to start fresh
mkdir /app


echo -e "${color}Download Application content${no_color}"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app


echo -e "${color}Extract Application content${no_color}"
unzip /tmp/payment.zip


echo -e "${color}Download Application Dependencies${no_color}"
pip3 install -r requirements.txt


echo -e "${color}Start Application Service${no_color}"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
