# Pester 5 separates Discovery and Run phases. Script-level variables set
# outside BeforeAll are not reliably available during Run. Resolve the repo
# root and discover scanner files inside BeforeAll using $PSCommandPath
# (absolute path to this test file when Pester loads it).
BeforeAll {
    $testFile = $null
    if ($PSCommandPath) {
        $testFile = $PSCommandPath
    } elseif ($MyInvocation.MyCommand.Path) {
        $testFile = $MyInvocation.MyCommand.Path
    }

    if ($testFile) {
        $script:Root = (Resolve-Path (Join-Path (Split-Path -Parent $testFile) '../..')).Path
    } elseif ($PSScriptRoot) {
        $script:Root = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
    } else {
        # CI invokes: Invoke-Pester ./tests/PowerShell from the repo root
        $script:Root = $PWD.Path
    }

    $script:ScriptFiles = @(
        Get-ChildItem -Path (Join-Path $script:Root 'scripts') -Filter '*.ps1' -Recurse -ErrorAction Stop
    )
}

Describe 'Energy-Grid-Protector repository' {
    It 'contains at least one PowerShell scanner file' {
        $script:ScriptFiles.Count | Should -BeGreaterThan 0
    }

    It 'has PowerShell scanner files that parse without errors' {
        foreach ($file in $script:ScriptFiles) {
            $tokens = $null
            $errors = $null
            [void][System.Management.Automation.Language.Parser]::ParseFile(
                $file.FullName,
                [ref]$tokens,
                [ref]$errors
            )
            $errors.Count | Should -Be 0
        }
    }

    It 'contains required governance and safety documentation' {
        @(
            'CHANGELOG.md',
            'CODE_OF_CONDUCT.md',
            'docs/safe-operation.md',
            'docs/threat-model.md',
            'docs/sample-report.md'
        ) | ForEach-Object {
            Test-Path -Path (Join-Path -Path $script:Root -ChildPath $_) | Should -BeTrue
        }
    }

    It 'states that use requires authorization' {
        $readme = Get-Content -Path (Join-Path -Path $script:Root -ChildPath 'README.md') -Raw
        $readme | Should -Match '(?i)authorized|permission'
    }
}
