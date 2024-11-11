#!/bin/bash

# Define color variables
COLOR_PURPLE="\e[35m"
COLOR_YELLOW="\e[33m"
NO_COLOR="\e[0m"

# Function to print messages with color
print_message() {
  local color="$1"
  local message="$2"
  echo -e "${color}${message}${NO_COLOR}"
}

# Function to install a package if it’s not already installed
install_package() {
  local package="$1"
  if ! rpm -q "$package" &>/dev/null; then
    print_message "$COLOR_YELLOW" "Installing $package..."
    dnf install -y "$package"
  else
    print_message "$COLOR_YELLOW" "$package is already installed."
  fi
}

# Function to create a user if it doesn’t already exist
create_user() {
  local user="$1"
  if ! id "$user" &>/dev/null; then
    print_message "$COLOR_YELLOW" "Creating user $user..."
    useradd "$user"
  else
    print_message "$COLOR_YELLOW" "User $user already exists."
  fi
}

# Function to create or clear a directory
create_directory() {
  local dir="$1"
  print_message "$COLOR_YELLOW" "Setting up directory $dir..."
  rm -rf "$dir"
  mkdir -p "$dir"
}

# Function to manage a systemd service (reload, enable, restart)
manage_service() {
  local service_name="$1"
  print_message "$COLOR_PURPLE" "Starting and enabling service $service_name..."
  systemctl daemon-reload
  systemctl enable "$service_name"
  systemctl restart "$service_name"
}

# Optional function to check if a command is available, and install it if missing
check_command() {
  local command="$1"
  if ! command -v "$command" &>/dev/null; then
    print_message "$COLOR_YELLOW" "Installing missing command: $command"
    dnf install -y "$command"
  fi
}
