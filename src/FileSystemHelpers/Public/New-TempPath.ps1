function New-TempPath {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    param (
        [string]$Extension
    )
    do {
        if ([System.String]::IsNullOrWhiteSpace($Extension)) {
            $name = (New-Guid).Guid
        } else {
            $name = '{0}.{1}' -f (New-Guid).Guid, $Extension
        }
        $tempPath = [System.IO.Path]::Combine((Get-TempPath), $name)
    } while (Test-Path -Path $tempPath)
    $tempPath
}
