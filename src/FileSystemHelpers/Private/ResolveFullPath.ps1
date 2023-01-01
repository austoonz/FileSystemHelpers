function ResolveFullPath {
    param ([string]$Path)
    if ($Path -notlike "*$([System.IO.Path]::DirectorySeparatorChar)*") {
        $Path = Join-Path -Path (Get-Location).Path -ChildPath $Path
    }
    $Path
}