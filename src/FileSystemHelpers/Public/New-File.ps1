function New-File {
    [CmdletBinding(SupportsShouldProcess)]
    [Alias('touch')]
    param (
        [ValidateScript({
            $_path = ResolveFullPath -Path $_
            -not(TestPathExists -Path $_path)
        })]
        [Parameter(ValueFromPipeline=$true)]
        [string[]] $Path
    )

    process {
        foreach ($p in $Path) {
            $_p = ResolveFullPath -Path $p

            if ($PSCmdlet.ShouldProcess($_p)) {
                New-Item -Path $_p -ItemType 'File' -WhatIf:$WhatIfPreference
            }
        }
    }
}
