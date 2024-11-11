Src Common.sh
# Copy Payment service file
echo -e "${color}Copy Payment service file${no_color}"
cp Payment.service /etc/systemd/system/payment.service

# Install Python3 and development tools
echo -e "${color}Install Python3 and required packages${no_color}"
dnf install python3 gcc python3-devel unzip -y

# Add Application User
echo -e "${color}Create Application User${no_color}"
useradd roboshop

# Create Application Directory
echo -e "${color}Create Application Directory${no_color}"
rm -rf /app  # Remove if it exists to start fresh
mkdir /app

# Download Application Content
echo -e "${color}Download Application content${no_color}"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip

# Navigate to Application Directory
cd /app

# Extract Application Content
echo -e "${color}Extract Application content${no_color}"
unzip /tmp/payment.zip

# Install Application Dependencies
echo -e "${color}Download Application Dependencies${no_color}"
pip3 install -r requirements.txt

# Start and Enable Application Service
echo -e "${color}Start Application Service${no_color}"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
