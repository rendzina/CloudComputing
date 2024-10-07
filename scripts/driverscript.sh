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
# Course       : cloud computing MK5014/MK6014
# Date         : 04/10/2024
# Version      : 1.0
################################################################################

# Check version of Ubuntu is 18.04 or later
if ! [[ "18.04 20.04 22.04 23.04 24.04" == *"$(lsb_release -rs)"* ]];
then
    echo "Ubuntu $(lsb_release -rs) is not currently supported.";
    exit;
fi

# Add the signature to trust the Microsoft repo
# For Ubuntu versions < 24.04 
# curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
# For Ubuntu versions >= 24.04
curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg

# Add repo to apt sources
curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

# Ensuring system is up to date
echo "Updating / Upgrading system"
sudo apt-get update
#sudo apt-get upgrade # if upgrades are also required

# Install the driver
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev