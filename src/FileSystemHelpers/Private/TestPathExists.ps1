function TestPathExists {
    param ([string]$Path)
    TestFileExists -Path $Path
    TestDirectoryExists -Path $Path
}
