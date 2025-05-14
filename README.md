# Microsoft ODBC Driver Installation Script

## Overview
This script automates the installation of Microsoft ODBC Driver 18 for SQL Server on Ubuntu systems. It's designed to simplify the setup process for developers working with SQL Server on Ubuntu environments.

## Features
- Automatic installation of Microsoft ODBC Driver 18
- Installation of optional SQL Server tools (bcp and sqlcmd)
- Installation of unixODBC development headers
- Comprehensive error handling and validation
- Internet connectivity verification
- Ubuntu version compatibility check
- Prevents duplicate installations

## Prerequisites
- Ubuntu 18.04 or later (18.04, 20.04, 22.04, 23.04, 24.04)
- Root privileges (sudo access)
- Internet connection
- PHP 8.3 (as required by the project)

## Installation
1. Clone this repository or download the script
2. Make the script executable:
   ```bash
   chmod +x scripts/driverscript.sh
   ```
3. Run the script with sudo:
   ```bash
   sudo ./scripts/driverscript.sh
   ```

## What Gets Installed
- Microsoft ODBC Driver 18 for SQL Server
- Microsoft SQL Server tools (bcp and sqlcmd)
- unixODBC development headers

## Script Details
- **Location**: `scripts/driverscript.sh`
- **Version**: 2
- **Last Updated**: 19/3/25
- **Reference**: [Microsoft Documentation](https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=azuresqldb-current)

## Error Handling
The script includes comprehensive error handling for:
- Missing root privileges
- No internet connection
- Unsupported Ubuntu versions
- Failed package installations
- Repository configuration issues

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

## Contributing
Feel free to submit issues and enhancement requests.

## License
This script is part of the Cloud Computing course (MK5014/MK6014) at MK:U.
