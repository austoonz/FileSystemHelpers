function New-TempFile {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$Extension
    )
    $tempPath = New-TempPath -Extension $Extension
    if ($PSCmdlet.ShouldProcess($tempPath)) {
        New-Item -Path $tempPath -ItemType 'File' -WhatIf:$WhatIfPreference
    }
}
