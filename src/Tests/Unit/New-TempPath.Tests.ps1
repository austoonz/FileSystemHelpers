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
    Describe -Name 'New-TempPath' -Fixture {
        Context -Name 'Happy Path' -Fixture {
            Mock -CommandName GetTempPath -MockWith {
                'TestDrive:'
            }

            $separator = [System.IO.Path]::DirectorySeparatorChar

            It -Name 'Returns a temporary path' -Test {
                $assertion = New-TempPath
                $assertion | Should -Not -BeNullOrEmpty

                $regex = "^TestDrive(:|:\$separator)[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}$"
                $assertion | Should -Match $regex
            }

            It -Name 'Returns a temporary path with a file extension' -Test {
                $assertion = New-TempPath -Extension 'txt'
                $assertion | Should -Not -BeNullOrEmpty

                $regex = "^TestDrive(:|:\$separator)[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}\.txt$"
                $assertion | Should -Match $regex
            }
        }

        Context -Name 'Sad Path' -Fixture {
            Mock -CommandName GetTempPath -MockWith {
                [String]::Empty
            }

            It -Name 'Throws a FileNotFoundException when no path is returned' -Test {
                { Get-TempPath } | Should -Throw -ExceptionType 'System.IO.FileNotFoundException'
            }
        }
    }
}
