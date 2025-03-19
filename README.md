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

## Troubleshooting
If you encounter issues:
1. Ensure you have sudo privileges
2. Check your internet connection
3. Verify your Ubuntu version is supported
4. Check the error messages provided by the script

## Contributing
Feel free to submit issues and enhancement requests.

## License
This script is part of the Cloud Computing course (MK5014/MK6014) at MK:U.
