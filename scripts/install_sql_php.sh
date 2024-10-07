#!/bin/bash

################################################################################
# Name         : installsql_php.sh
# Description  : This script installs the PHP drivers for Azure SQL database.
#                PHP and the ODBC driver must have been installed prior to 
#                running this script.
# MK:U Cloud Computing
# Reference    : https://learn.microsoft.com/en-us/sql/connect/php/installation-tutorial-linux-mac?view=azuresqldb-current
# Requires     : PHP 8.3
#
# Course       : cloud computing MK5014/MK6014
# Date         : 04/10/2024
# Version      : 1.0
################################################################################

# Ensuring system is up to date
echo "Updating / Upgrading system"
sudo apt-get update
#sudo apt-get upgrade # if upgrades are also required

# Install the PHP pre-requisites:
echo "Installing php-dev"
apt install php-dev

# Install the Ubuntu (the operating system) pre-requisites, unixodbc-dev 
# It is used by the pecl command to install the PHP drivers.
echo "Installing Ubuntu pre-requisites"
sudo apt-get install unixodbc-dev

# Install the PHP drivers for Microsoft SQL Server
# PECL is a a repository of PHP extensions 
#(see https://pecl.php.net/package/sqlsrv)
echo "Installing PHP drivers for Microsoft SQL Server"
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv

# the following printf commands creates '.ini' files in the php version 8.3 directory withe the text in quotes
sudo su -c 'printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.3/mods-available/sqlsrv.ini; printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.3/mods-available/pdo_sqlsrv.ini'

# phpenmod is used to enable the sql server module in php
# (see https://tecadmin.net/enable-disable-php-modules-ubuntu/)
sudo phpenmod sqlsrv pdo_sqlsrv

# restart Apache
echo "restarting Apache"
sudo service apache2 restart