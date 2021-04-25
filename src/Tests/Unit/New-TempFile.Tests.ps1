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
            Mock -CommandName GetTempPath -MockWith {
                'TestDrive:\'
            }

            It -Name 'Returns a FileInfo object' -Test {
                $assertion = New-TempFile
                $assertion | Should -BeOfType 'System.IO.FileInfo'
            }

            It -Name 'Returns a temporary file that exists' -Test {
                $assertion = New-TempFile
                Test-Path -Path $assertion -PathType 'Leaf' | Should -BeTrue
            }
        }

        Context -Name 'Sad Path' -Fixture {
            Mock -CommandName GetTempPath -MockWith {
                [String]::Empty
            }

            It -Name 'Throws a FileNotFoundException when no path is returned' -Test {
                { New-TempFile } | Should -Throw -ExceptionType 'System.IO.FileNotFoundException'
            }
        }
    }
}
