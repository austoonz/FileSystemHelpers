function TestDirectoryExists {
    param ([string]$Path)
    if ([System.IO.Directory]::Exists($Path)) {
        throw "A directory exists at the path '$Path'."
    }
}
