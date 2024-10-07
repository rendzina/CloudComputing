#!/bin/bash

# MK:U Cloud Computing
# Script to help automate installation of PHP and PHP drivers
# for AzureSQL on MS Azure

# Start by ensuring system is up to date
echo "Updating / Upgrading system"
sudo apt update
#sudo apt upgrade # if upgrades are also required

# Install the PHP pre-requisites:
echo "Installing php-dev"
apt install php-dev

# Install the Ubuntu (the operating system) pre-requisites
echo "Installing Ubntu pre-requisites"
sudo apt-get install unixodbc-dev

# Install the PHP drivers for Microsoft SQL Server
echo "Installing PHP rivers for Microsoft SQL Server"
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
sudo su -c printf '; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.3/mods-available/sqlsrv.ini; printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.3/mods-available/pdo_sqlsrv.ini'
sudo phpenmod sqlsrv pdo_sqlsrv

# restart Apache
echo "restarting Apache"
sudo service apache2 restart