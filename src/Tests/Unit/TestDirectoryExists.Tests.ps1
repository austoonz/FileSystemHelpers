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
    Describe -Name 'TestDirectoryExists' -Fixture {
        It -Name 'Returns nothing when the directory does not exist' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfolder'
            $null = Remove-Item -Path $testPath -Force -ErrorAction SilentlyContinue
            $assertion = TestDirectoryExists -Path $testPath
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Returns nothing when the target location is a file' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfile'
            $null = Remove-Item -Path $testPath -Force -ErrorAction SilentlyContinue
            $null = New-Item -Path $testPath -ItemType File -Force
            $assertion = TestDirectoryExists -Path $testPath
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Throws when the directory exists' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfolder'
            $null = New-Item -Path $testPath -ItemType Directory -Force
            { TestDirectoryExists -Path $testPath } | Should -Throw
        }
    }
}
