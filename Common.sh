# common.sh

# Define color variables
COLOR="\e[33m"
NO_COLOR="\e[0m"

# Function to print messages in color
print_message() {
    echo -e "${COLOR}$1${NO_COLOR}"
}

# Function to install a package
install_package() {
    dnf install -y "$1"
}

# Function to create a user
create_user() {
    id "$1" &>/dev/null || useradd "$1"
}

# Function to create a directory
create_directory() {
    rm -rf "$1"
    mkdir -p "$1"
}

# Function to manage a service
manage_service() {
    systemctl daemon-reload
    systemctl enable "$1"
    systemctl restart "$1"
}
