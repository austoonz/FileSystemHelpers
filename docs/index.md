# FileSystemHelpers

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)

Helper functions for file system operations in PowerShell.

## Overview

FileSystemHelpers provides utility functions for common file system operations, including:

- Creating temporary files and directories
- Path manipulation and merging
- Cross-platform temp path handling

## Installation

Install from the [PowerShell Gallery](https://www.powershellgallery.com/packages/FileSystemHelpers):

```powershell
# Install for current user
Install-Module -Name FileSystemHelpers -Scope CurrentUser

# Install for all users (requires admin)
Install-Module -Name FileSystemHelpers -Scope AllUsers
```

## Quick Start

```powershell
# Get the system temp path
Get-TempPath

# Create a new temporary directory
New-TempDirectory

# Create a new temporary file
New-TempFile

# Merge path segments
Merge-Path -Path 'C:\Users' -ChildPath 'Documents' -AdditionalChildPath 'Projects'

# Create a file (like Unix touch command)
New-File -Path 'C:\temp\newfile.txt'
# Or use the alias
touch 'C:\temp\newfile.txt'
```

## Functions

| Function | Description |
|----------|-------------|
| [Get-TempPath](functions/Get-TempPath.md) | Gets the system temporary directory path |
| [Merge-Path](functions/Merge-Path.md) | Merges multiple path segments into a single path |
| [New-File](functions/New-File.md) | Creates a new file (similar to Unix touch) |
| [New-TempDirectory](functions/New-TempDirectory.md) | Creates a new temporary directory |
| [New-TempFile](functions/New-TempFile.md) | Creates a new temporary file |
| [New-TempPath](functions/New-TempPath.md) | Generates a new temporary path without creating it |

## Requirements

- Windows PowerShell 5.1 or PowerShell 7.x
- Supported platforms: Windows, Linux, macOS

## Contributing

Contributions are welcome! Please see the [repository](https://github.com/austoonz/FileSystemHelpers) for details.

```powershell
# Clone the repository
git clone https://github.com/austoonz/FileSystemHelpers.git
cd FileSystemHelpers

# Install dependencies
.\install_modules.ps1

# Build the module
.\build.ps1 -Build

# Run tests
.\build.ps1 -Test
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/austoonz/FileSystemHelpers/blob/main/LICENSE) file for details.

## Author

[Andrew Pearce](https://twitter.com/austoonz) - [https://andrewpearce.io](https://andrewpearce.io)
