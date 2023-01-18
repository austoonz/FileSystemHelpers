<#
.SYNOPSIS
Combines a list of paths into a single path.
#>
function Merge-Path {
    [CmdletBinding()]
    param (
        # A list of paths to combine.
        [string[]]$Path
    )
    [System.IO.Path]::Combine($Path)
}
