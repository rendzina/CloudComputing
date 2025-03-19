#!/bin/bash

################################################################################
# Name         : installsql_php.sh
# Description  : This script installs the Microsoft ODBC driver 18 from the bash shell for Ubuntu and was copied 
#                directly from the Microsoft learn/SQL/SQL server web page
# MK:U Cloud Computing
#
# Reference    : https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=azuresqldb-current
# Requires     : PHP 8.3
#
# Course       : Cloud Computing MK5014/MK6014
# Date         : 19/3/25
# Version      : 2
################################################################################

# Exit on error
set -e

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check internet connectivity
check_internet() {
    if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        echo "No internet connection detected. Please check your connection and try again."
        exit 1
    fi
}

# Check if running with sudo privileges
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Check internet connectivity
check_internet

# Check version of Ubuntu is 18.04 or later
if ! [[ "18.04 20.04 22.04 23.04 24.04" == *"$(lsb_release -rs)"* ]]; then
    echo "Ubuntu $(lsb_release -rs) is not currently supported."
    exit 1
fi

# Check if ODBC driver is already installed
if command_exists odbcinst && odbcinst -q -d | grep -q "ODBC Driver 18 for SQL Server"; then
    echo "Microsoft ODBC Driver 18 is already installed."
    exit 0
fi

# Add the signature to trust the Microsoft repo
# For Ubuntu versions < 24.04 
# curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
# For Ubuntu versions >= 24.04
if ! curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg; then
    echo "Failed to add Microsoft GPG key"
    exit 1
fi

# Add repo to apt sources
if ! curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | tee /etc/apt/sources.list.d/mssql-release.list; then
    echo "Failed to add Microsoft repository"
    exit 1
fi

# Ensuring system is up to date
echo "Updating system"
if ! apt-get update; then
    echo "Failed to update package list"
    exit 1
fi

# Install the driver
echo "Installing Microsoft ODBC Driver 18..."
if ! ACCEPT_EULA=Y apt-get install -y msodbcsql18; then
    echo "Failed to install Microsoft ODBC Driver 18"
    exit 1
fi

# Install optional tools
echo "Installing optional tools..."
if ! ACCEPT_EULA=Y apt-get install -y mssql-tools18; then
    echo "Failed to install mssql-tools18"
    exit 1
fi

# Add tools to PATH
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc

# Install unixODBC development headers
if ! apt-get install -y unixodbc-dev; then
    echo "Failed to install unixodbc-dev"
    exit 1
fi

echo "Installation completed successfully!"
