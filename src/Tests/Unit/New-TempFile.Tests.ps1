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
    Describe -Name 'New-TempFile' -Fixture {
        Context -Name 'Happy Path' -Fixture {
            It -Name 'Returns a FileInfo object' -Test {
                Mock -CommandName GetTempPath -MockWith {$TestDrive}

                $assertion = New-TempFile
                $assertion | Should -BeOfType 'System.IO.FileInfo'
            }

            It -Name 'Returns a temporary file that exists' -Test {
                Mock -CommandName GetTempPath -MockWith {$TestDrive}

                $assertion = New-TempFile
                Test-Path -Path $assertion -PathType 'Leaf' | Should -BeTrue
            }
        }

        Context -Name 'Sad Path' -Fixture {
            It -Name 'Throws a FileNotFoundException when no path is returned' -Test {
                Mock -CommandName GetTempPath -MockWith {[String]::Empty}

                { New-TempFile } | Should -Throw -ExceptionType 'System.IO.FileNotFoundException'
            }
        }
    }
}
