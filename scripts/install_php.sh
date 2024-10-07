#!/bin/bash

################################################################################
# Name         : installphp.sh
# Description  : This script installs php and the php Apache2 package
# MK:U Cloud Computing
#
# Reference    : https://documentation.ubuntu.com/server/how-to/web-services/install-php/
# Requires     : Ubuntu 24.04, Apache2
#
# Course       : cloud computing MK5014/MK6014
# Date         : 04/10/2024
# Version      : 1.0
################################################################################

# check version of ubuntu - exit if not latest
if ! [[ "24.04" == *"$(lsb_release -rs)"* ]];
then
  echo "Ubuntu $(lsb_release -rs) is not currently supported.";
  exit;
else
 echo "Ubuntu $(lsb_release -rs)"
fi

# Ensuring system is up to date
echo "Updating / Upgrading system"
sudo apt-get update
#sudo apt-get upgrade # if upgrades are also required

# check Apache is installed. This is required before we install php. exit if not
if [[ -z $(apache2 -v 2>/dev/null) ]] && [[ -z $(httpd -v 2>/dev/null) ]]; 
then 
   echo "Apache not found"; 
   exit;
else
  echo "Apache installed"; 
fi

# install PHP and libapache2-mod-php package
# libapache2_mod_php is the PHP plugin in Apache
echo "installing php"
sudo apt install php libapache2-mod-php

# restart Apache2 web server
echo "restarting apache2 service"
sudo systemctl restart apache2.service

# show php version-  must be PHP 8.3
echo "Current version of PHP:"
php -version