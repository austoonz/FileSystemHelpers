function Get-TempPath {
    $tempPath = GetTempPath
    if ([String]::IsNullOrEmpty($tempPath)) {
        throw [System.IO.FileNotFoundException]::new('The temporary path returned by [System.IO.Path]::GetTempPath() is empty.')
    }
    $tempPath
}
