# Example final web page and Microsoft ODBC Driver Installation Script

## Overview
This repository contains scripts for setting up and testing Microsoft SQL Server connectivity on Ubuntu systems. It includes an installation script for the ODBC driver and a PHP test page for verifying the connection.

## Features
- Automatic installation of Microsoft ODBC Driver 18
- Installation of optional SQL Server tools (bcp and sqlcmd)
- Installation of unixODBC development headers
- Comprehensive error handling and validation
- Internet connectivity verification
- Ubuntu version compatibility check
- Prevents duplicate installations
- PHP test page for connection verification

## Prerequisites
- Ubuntu 18.04 or later (18.04, 20.04, 22.04, 23.04, 24.04)
- Root privileges (sudo access)
- Internet connection
- PHP 8.3 (as required by the project)
- Web server (Apache/Nginx) for PHP test page

## Installation
1. Clone this repository or download the scripts
2. Make the installation script executable:
   ```bash
   chmod +x scripts/driverscript.sh
   ```
3. Run the installation script with sudo:
   ```bash
   sudo ./scripts/driverscript.sh
   ```
4. Configure the PHP test page:
   - Navigate to `html/sqltest.php`
   - Update the database configuration with your credentials:
     ```php
     $serverName = "tcp:<<DATABASE SERVER NAME>>.database.windows.net,1433";
     $connectionInfo = [
         "UID" => "<<DATABASE SERVER NAME>>",
         "pwd" => "<<PASSWORD>>",
         "Database" => "<<DATABASE NAME>>"
     ];
     ```

## What Gets Installed
- Microsoft ODBC Driver 18 for SQL Server
- Microsoft SQL Server tools (bcp and sqlcmd)
- unixODBC development headers

## Script Details
- **ODBC Driver Installation**: `scripts/driverscript.sh`
  - Version: 2
  - Last Updated: 19/3/25
  - Reference: [Microsoft Documentation](https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=azuresqldb-current)

- **SQL Test Page**: `html/sqltest.php`
  - Bootstrap-styled interface
  - Error handling and display
  - Responsive table for data display
  - Connection status feedback

## Error Handling
The scripts include comprehensive error handling for:
- Missing root privileges
- No internet connection
- Unsupported Ubuntu versions
- Failed package installations
- Repository configuration issues
- Database connection failures
- Query execution errors

## Environment Setup
After installation, the script automatically:
- Adds SQL Server tools to your PATH
- Updates your current shell environment

## Verification
To verify the installation was successful:
1. Check ODBC driver installation:
   ```bash
   odbcinst -q -d
   ```
2. Verify SQL Server tools:
   ```bash
   bcp -v
   sqlcmd -?
   ```
3. Check PATH configuration:
   ```bash
   echo $PATH | grep mssql-tools18
   ```
4. Test database connection:
   - Open `html/sqltest.php` in your web browser
   - Verify successful connection and data display
   - Check for any error messages

## Troubleshooting
If you encounter issues:

1. **Permission Denied**
   - Ensure you're using sudo
   - Check if you have root privileges
   - Verify script permissions (should be executable)

2. **Internet Connection Issues**
   - Check your network connection
   - Verify you can ping 8.8.8.8
   - Ensure you can access Microsoft's repositories

3. **Version Compatibility**
   - Run `lsb_release -rs` to check your Ubuntu version
   - Ensure you're running a supported version (18.04 or later)

4. **Package Installation Failures**
   - Check system logs: `tail -f /var/log/syslog`
   - Verify repository configuration
   - Ensure system is up to date: `sudo apt-get update`

5. **PATH Issues**
   - Check if PATH was updated: `echo $PATH`
   - Verify .bashrc was modified correctly
   - Try sourcing .bashrc manually: `source ~/.bashrc`

6. **PHP Test Page Issues**
   - Verify PHP installation: `php -v`
   - Check web server configuration
   - Verify database credentials
   - Check PHP error logs

## Contributing
Feel free to submit issues and enhancement requests.

## License
This script is part of the Cloud Computing course (MK5014/MK6014) at MK:U.
