function TestFileExists {
    param ([string]$Path)
    if ([System.IO.File]::Exists($Path)) {
        throw "A file exists at the path '$Path'."
    }
}
