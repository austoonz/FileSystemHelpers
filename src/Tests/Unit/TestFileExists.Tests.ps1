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
    Describe -Name 'TestFileExists' -Fixture {
        It -Name 'Returns nothing when the file does not exist' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfile.txt'
            $null = Remove-Item -Path $testPath -Force -ErrorAction SilentlyContinue
            $assertion = TestFileExists -Path $testPath
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Returns nothing when the target location is a directory' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfolder'
            $null = Remove-Item -Path $testPath -Force -ErrorAction SilentlyContinue
            $null = New-Item -Path $testPath -ItemType Directory -Force
            $assertion = TestFileExists -Path $testPath
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Throws when the file exists' -Test {
            $testPath = Join-Path -Path $Testdrive -ChildPath 'testfile.txt'
            $null = New-Item -Path $testPath -ItemType File -Force
            { TestFileExists -Path $testPath } | Should -Throw
        }
    }
}
