cp mongoDB.repo /etc/yum.repos.d/mongodb.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod