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
    Describe -Name 'New-File' -Fixture {
        BeforeEach {
            Remove-Item -Path "TestFile" -Force -ErrorAction 'SilentlyContinue'
            Remove-Item -Path "$TestDrive\TestFile" -Force -ErrorAction 'SilentlyContinue'
        }

        Context -Name 'Happy Path' -Fixture {
            It -Name 'Returns a FileInfo object using a full path' -Test {
                $assertion = New-File -Path "$TestDrive\TestFile"
                $assertion | Should -BeOfType 'System.IO.FileInfo'
            }

            It -Name 'Returns a FileInfo object using only a file name' -Test {
                $assertion = New-File -Path "TestFile"
                $assertion | Should -BeOfType 'System.IO.FileInfo'
            }
        }

        Context -Name 'Sad Path' -Fixture {
            It -Name 'Throws an exception when a file already exists' -Test {
                $null = New-Item -Path "$TestDrive\TestFile" -ItemType 'File'
                { New-File -Path "$TestDrive\TestFile" } | Should -Throw
            }

            It -Name 'Throws an exception when a file already exists' -Test {
                $null = New-Item -Path "$TestDrive\TestFile" -ItemType 'Directory'
                { New-File -Path "$TestDrive\TestFile" } | Should -Throw
            }
        }
    }
}
