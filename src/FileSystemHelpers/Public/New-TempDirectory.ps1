function New-TempDirectory {
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    $tempPath = New-TempPath
    if ($PSCmdlet.ShouldProcess($tempPath)) {
        New-Item -Path $tempPath -ItemType 'Directory' -WhatIf:$WhatIfPreference
    }
}
