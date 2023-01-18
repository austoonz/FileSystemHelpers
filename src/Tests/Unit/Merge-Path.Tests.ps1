$global:WarningPreference = 'SilentlyContinue'
Set-Location -Path $PSScriptRoot

$ModuleName = 'FileSystemHelpers'

$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")

if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue')
{
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force

InModuleScope -ModuleName 'FileSystemHelpers' -ScriptBlock {
    Describe -Name 'Merge-Path' -Fixture {
        It -Name '<Name>' -TestCases @(
            @{
                Name = 'Supports a single path'
                Path = @([System.IO.Path]::DirectorySeparatorChar)
                Expected = [System.IO.Path]::DirectorySeparatorChar
            }
            @{
                Name = 'Supports two path entries'
                Path = @([System.IO.Path]::DirectorySeparatorChar, 'Test')
                Expected = '{0}Test' -f [System.IO.Path]::DirectorySeparatorChar
            }
            @{
                Name = 'Supports more than two path entries'
                Path = @([System.IO.Path]::DirectorySeparatorChar, 'Test', 'File.txt')
                Expected = '{0}Test{1}File.txt' -f [System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::DirectorySeparatorChar
            }
        ) -Test {
            $assertion = Merge-Path -Path $Path
            $assertion | Should -BeExactly $Expected
        }
    }
}
