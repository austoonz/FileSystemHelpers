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
    Describe -Name 'New-TempDirectory' -Fixture {
        Context -Name 'Happy Path' -Fixture {
            It -Name 'Returns a DirectoryInfo object' -Test {
                Mock -CommandName GetTempPath -MockWith {$TestDrive}

                $assertion = New-TempDirectory
                $assertion | Should -BeOfType 'System.IO.DirectoryInfo'
            }

            It -Name 'Returns a temporary directory that exists' -Test {
                Mock -CommandName GetTempPath -MockWith {
                    $TestDrive
                }

                $assertion = New-TempDirectory
                Test-Path -Path $assertion -PathType 'Container' | Should -BeTrue
            }
        }

        Context -Name 'Sad Path' -Fixture {
            It -Name 'Throws a FileNotFoundException when no path is returned' -Test {
                Mock -CommandName GetTempPath -MockWith {
                    [String]::Empty
                }

                { New-TempDirectory } | Should -Throw -ExceptionType 'System.IO.FileNotFoundException'
            }
        }
    }
}
