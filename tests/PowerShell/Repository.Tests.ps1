BeforeAll {$Root=Split-Path -Parent (Split-Path -Parent $PSScriptRoot);$Scripts=Get-ChildItem (Join-Path $Root 'scripts') -Recurse -Filter '*.ps1'}
Describe 'Energy-Grid-Protector repository' {
  It 'contains PowerShell scanner files' {$Scripts.Count | Should -BeGreaterThan 0}
  It 'parses every PowerShell scanner without errors' -ForEach $Scripts {$t=$null;$e=$null;[void][System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$t,[ref]$e);$e.Count | Should -Be 0}
  It 'contains required safety documentation' {@('CHANGELOG.md','CODE_OF_CONDUCT.md','docs/safe-operation.md','docs/threat-model.md','docs/sample-report.md') | ForEach-Object {Test-Path (Join-Path $Root $_) | Should -BeTrue}}
  It 'states that use requires authorization' {(Get-Content (Join-Path $Root 'README.md') -Raw) | Should -Match '(?i)authorized|permission'}
}
