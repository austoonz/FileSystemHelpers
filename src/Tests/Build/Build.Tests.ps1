Describe -Name 'Module Manifest' -Fixture {
    BeforeAll {
        $script:ModuleName = 'FileSystemHelpers'
        $script:ModuleManifest = [System.IO.Path]::Combine($PSScriptRoot, '..', '..', '..', 'Artifacts', "$ModuleName.psd1")
        Import-Module $script:ModuleManifest -Force -ErrorAction 'Stop'
    }

    Context -Name 'Exported Functions' -Fixture {
        It -Name 'Exports the correct number of functions' -Test {
            $assertion = Get-Command -Module $script:ModuleName -CommandType Function
            $assertion | Should -HaveCount 6
        }

        It -Name '<_>' -TestCases @(
            'Get-TempPath'
            'Merge-Path'
            'New-File'
            'New-TempDirectory'
            'New-TempFile'
            'New-TempPath'
        ) -Test {
            {Get-Command -Name $_ -Module $script:ModuleName -ErrorAction Stop} | Should -Not -Throw
        }
    }
}